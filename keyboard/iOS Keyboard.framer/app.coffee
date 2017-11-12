# Require input module
{InputLayer} = require "input"

# Wrap input layer
input = InputLayer.wrap(bg, text)

# Keyboard Simulator
# Variables
lettersActive = true 
numbersActive = false
showLeftKey = false 
showRightKey = false
showLargeKey = false

# Methods 		
## Show active key
showActiveKey = (key, showLeftKey, showRightKey) ->

	offsetX = 2 
	offsetY = 3
	
	currentActiveKey = activeKey
	currentActiveLetter = activeLetter
	
	if showLeftKey
		currentActiveKey = activeKeyLeft
		currentActiveLetter = activeLetterLeft
		offsetX = -19
		
	else if showRightKey
		currentActiveKey = activeKeyRight
		currentActiveLetter = activeLetterRight
		offsetX = 11
		
	else if showLargeKey
		currentActiveKey = activeKeyLarge
		currentActiveLetter = activeLetterLarge
		offsetX = -8
		
	currentActiveKey.opacity = 1
	currentActiveKey.point = 
		x: key.x - (key.width / 2) - 5 - offsetX
		y: key.y - currentActiveKey.height + key.height + offsetY
		
	if lettersActive
		currentActiveKey.parent = keyboard
		currentActiveLetter.text = key.name
	
	if numbersActive
		currentActiveKey.parent = numeric 
		currentActiveLetter.text = key.name
		currentActiveLetter.x = Align.center
	
	if shiftIconActive.visible
		currentActiveLetter.textTransform = "uppercase"			
	else
		currentActiveLetter.textTransform = "lowercase"
				
	
## Map all keys
mapLetterKeys = (e) ->	
	for key in letters.children
		name = String.fromCharCode(e.which) 
		
		if key.name is name
		
			if name is "q"
				showLeftKey = true
				showRightKey = false
			if name is "p"
				showLeftKey = false 
				showRightKey = true 
			
			showActiveKey(key, showLeftKey, showRightKey, showLargeKey)			

mapNumberKeys = (e) ->	
	for key in numbers.children
		name = String.fromCharCode(e.which) 
		
		if key.name is name
					
			if name is "1" or name is "-"
				showLeftKey = true
				showRightKey = false
				showLargeKey = false
			if name is "0" or name is "“"
				showLeftKey = false
				showRightKey = true
				showLargeKey = false
			if name is "."
				showLeftKey = false
				showRightKey = false 
				showLargeKey = true 
		
			showActiveKey(key, showLeftKey, showRightKey, showLargeKey)		
								
## Uppercase & Lowercase
setUppercase = ->
	for key in letters.children
		key.children[0].textTransform = "uppercase"
		key.children[0].x = Align.center()
		key.children[0].y = Align.center(1)
		shiftIconActive.visible = true
		shiftIcon.visible = false
		
setLowercase = ->
	for key in letters.children
		key.children[0].textTransform = "lowercase"
		key.children[0].x = Align.center()
		key.children[0].y = Align.center(-1)
		shiftIconActive.visible = false
		shiftIcon.visible = true
		
checkValue = ->
	if input.value == ""
		setUppercase()
	else
		setLowercase()
		
# Tap interactions for letters
for key in letters.children
		
	key.onTapStart ->
		return if numbersActive
		
		showLeftKey = false 
		showRightKey = false
		showLargeKey = false
		
		if @name is "q"
			showLeftKey = true 
			showRightKey = false
			showLargeKey = false
		if @name is "p"
			showLeftKey = false 
			showRightKey = true
			showLargeKey = false
				
		showActiveKey(this, showLeftKey, showRightKey, showLargeKey)
					
	key.onTapEnd ->
		return if numbersActive
				
		currentActiveKey = activeKey
		currentActiveLetter = activeLetter
		
		if showLeftKey
			currentActiveKey = activeKeyLeft
			currentActiveLetter = activeLetterLeft
			
		else if showRightKey
			currentActiveKey = activeKeyRight
			currentActiveLetter = activeLetterRight
			
		currentActiveKey.opacity = 0
		input._inputElement.focus()
		
		if shiftIconActive.visible
			input.value += currentActiveLetter.text.toUpperCase()		
		else
			input.value += currentActiveLetter.text
			
		checkValue()
		input.emit(Events. ValueChange, input.value)
	
# Tap interactions for numbers
for key in numbers.children
		
	key.onTapStart ->
		return if lettersActive
		
		showLeftKey = false 
		showRightKey = false
		showLargeKey = false
		
		if @name is "1" or @name is "-"
			showLeftKey = true 
			showRightKey = false
			showLargeKey = false
		if @name is "0" or @name is "“"
			showLeftKey = false 
			showRightKey = true 
			showLargeKey = false
		if @name is "." or @name is "," or @name is "?" or @name is "!" or @name is "‘"
			showLeftKey = false 
			showRightKey = false 
			showLargeKey = true
				
		showActiveKey(this, showLeftKey, showRightKey, showLargeKey)
					
	key.onTapEnd ->
		return if lettersActive
		
		currentActiveKey = activeKey
		currentActiveLetter = activeLetter
		
		if showLeftKey
			currentActiveKey = activeKeyLeft
			currentActiveLetter = activeLetterLeft
			
		else if showRightKey
			currentActiveKey = activeKeyRight
			currentActiveLetter = activeLetterRight
		
		else if showLargeKey
			currentActiveKey = activeKeyLarge
			currentActiveLetter = activeLetterLarge
			
		currentActiveKey.opacity = 0
		input._inputElement.focus()
			
		input.value += currentActiveLetter.text
		input.emit(Events.InputValueChange, input.value)	
		
# Keyboard methods	
document.onkeydown = (e) ->
	
	# Shift down
	if e.which == 16
		if shiftIconActive.visible
			return 
		else
			setUppercase()	
								
document.onkeypress = (e) ->
	
	if lettersActive
		mapLetterKeys(e)
		
	if numbersActive
		mapNumberKeys(e)
		
	# Space down
	if e.which == 32
		space.backgroundColor = "#ACB4BC"
	
					
document.onkeyup = (e) ->
	
	currentActiveKey = activeKey
	
	if showLeftKey
		currentActiveKey = activeKeyLeft
		
	else if showRightKey
		currentActiveKey = activeKeyRight
		
	currentActiveKey.opacity = 0
	
	# Space up
	if e.which == 32
		space.backgroundColor = "#FFFFFF"
	
	# Shift up 
	if e.which == 16
		setLowercase()
	
	checkValue()
		
# Extras
# Space
space.onTap -> input.value += " "	
space.onTapStart -> @backgroundColor = "#ACB4BC"	
space.onTapEnd -> @backgroundColor = "#FFFFFF"
input.onSpaceKey -> space.backgroundColor = "#ACB4BC"

# Return
returnKey.onTapStart -> @backgroundColor = "#FFFFFF"	
returnKey.onTapEnd -> @backgroundColor = "#ACB4BC"
returnKey.onTap ->
	if input.multiLine
		input.value += "\n"
			
# Shift			
shift.onTap ->
	if shiftIconActive.visible
		setLowercase()					
	else
		setUppercase()
		
# Caps lock
input.onCapsLockKey ->
	if shiftIconActive.visible
		setLowercase()
	else 
		setUppercase()

# Backspace
backspace.onTapStart ->
	backSpaceIcon.visible = false
	backSpaceIconActive.visible = true
	input.value = input.value.slice(0, -1)
	
backspace.onTapEnd ->
	backSpaceIcon.visible = true
	backSpaceIconActive.visible = false
	
# Numbers
numbersKey.onTap (event) ->
	lettersActive = false 
	numbersActive = true

	numeric.x = 0
	numeric.y = Screen.height - numeric.height
	numeric.parent = screenA
	
lettersKey.onTap (event) ->
	lettersActive = true 
	numbersActive = false

	numeric.x = Screen.width
	
# Hide on mobile
unless Utils.isDesktop()
	keyboard.opacity = 0
	numeric.opacity = 0
