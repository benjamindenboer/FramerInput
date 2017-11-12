.PHONY: help clean

default: help

clean:
	git clean -Xdf
	scripts/rm-unused-images.sh

help:
	@echo "Run \`make clean\` to remove all cruft from .framer folders (before packaging)"

