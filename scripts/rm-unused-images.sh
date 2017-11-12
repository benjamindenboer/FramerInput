#!/bin/bash

function rm_unused_images {
	cat framer/design.vekter | grep '"image"' | tr -s ' ' | cut -d' ' -f4 | cut -c2- | cut -d. -f1 > used-images
	find images/design/* | grep -v -f used-images | xargs rm
	rm used-images
}

IFS="
"

for project in $(find . -name "*.framer"); do
	cd "$project"
	rm_unused_images
	cd - >/dev/null
done
