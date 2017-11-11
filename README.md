<h1 align="center">
  <img src="https://d.pr/i/n8cWkV+" width="160" alt="icon"><br>
  Framer Input<br>
  <br>
</h1>
<br>
<p align="center">  
  <img src="https://d.pr/free/i/tydsBb+" width="840" alt="banner">
  <br>
  <h6 align="center">INTRODUCTION</h6>
  <p align="center">From inputs in <a href="https://framer.com/features/design?utm_source=github&utm_medium=link&utm_campaign=framer_audio_benjamin">Design</a> to fully functional ones in <a href="https://framer.com/features/code?utm_source=github&utm_medium=link&utm_campaign=framer_audio_benjamin">Code</a>. A <strong>Framer</strong> module that allows you to create single-line and multi-line input fields in Code and Design. Also includes an iOS keyboard simulator.</p>
 <p align="center"><a href="https://youtu.be/KCeOa9F3L9A">Watch the video.</a></p>
</p>
<br>

## Overview
All included properties and methods.


| Properties    | Type          | Description |
| ------------- | ------------- |----------- |
| new InputLayer    | Class  | Initiate a new Input object. |
| InputLayer.wrap    | Method  |Wrap input object around two layers. |
| InputLayer.value    | String  |  Text value of input layer. |
| InputLayer.focusColor    | Color  | Color of input layer on focus. |
| InputLayer.multiLine    | Boolean  | Single or multi-line input field. |
| InputLayer.onEnterKey    | Event  | On return key press. |
| InputLayer.onSpaceKey    | Event  | On space key press. |
| InputLayer.onBackSpaceKey    | Event | On backspace key press. |
| InputLayer.onCapsLockKey    | Event | On caps space key press. |
| InputLayer.onShiftKey    | Event  |  On shift key press. |
| InputLayer.onInputValueChange    | Event  | On input key press. |
| InputLayer.onInputFocus    | Event  | On input focus. |
| InputLayer.onInputBlur    | Event  | On input blur. |


<br>

## Design Guide
First, grab the `input.coffee` file and place it within the `/modules` folder (located within your `.framer` folder).
Then, to include the module, `require` the `Input` class:

```javascript
{InputLayer} = require "input"
```

Once you have created a simple input field in Design, you can make the wrapper layer (`background`) and the placeholder copy (`text`) targetable, and wrap them in Code.

The `InputLayer.wrap` method takes two parameters:
- `background` — The background layer of the input field.
- `text` — The placeholder text layer of the input field.

```javascript
input = InputLayer.wrap(background, text)
```

Now, the input field is functional. It automatically sets a `focusColor` for you (changes the color of the text), but this is completely customizable. The `input` object has its own `onValueChange` method. To use the text contents as you’re typing, simply reference the `value` property in combination with the event.

```javascript
input.onValueChange ->
	print input.value 
```

The `wrap` method allows you to pass in optional properties, too. For instance, if you’d like to create a `multiLine` input field (also known as a `textarea`), you can simply pass it along:

```javascript
input = InputLayer.wrap(bg, text, multiLine: true)
```


## Code Guide
New `InputLayers` can be initiated in Code, too.

```javascript
input = new InputLayer
```

This will create a functional input field, with its default placeholder. Note that the `InputLayer` class is based on the `TextLayer` class, and thus will inherit its properties and methods as well.

```javascript
input = new InputLayer
	text: "Placeholder"
```

To style the placeholder text, you can use all of the [TextLayer](https://framer.com/docs/?utm_campaign=framer_input_benjamin#text.textlayer) properties.

```javascript
input.fontSize = 40
input.fontWeight = 600
input.color = "red"
```

The `Input` class has its own `onValueChange` method, too. To use the text contents as you’re typing, simply reference the `value` property in combination with the event.

```javascript
input.onValueChange ->
	print input.value 
```



---

## Examples
- **[Play, Pause](https://framer.cloud/BsbYC)**. Two artboards, one Audio object.

## More Resources
- [MDN Keyboard Event Reference](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent).
- [MDN Key Property Reference](https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key).
- [HTML DOM Events Reference](https://www.w3schools.com/jsref/dom_obj_event.asp).
---

## Contact
- Follow me <a href="https://twitter.com/benjaminnathan">@benjaminnathan</a>.
- Follow <a href="https://twitter.com/framer">@framer</a>.
