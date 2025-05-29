# Idea to turn building blog into make...
# https://til.jakelazaroff.com/make/build-all-files-with-a-given-extension/

INPUTS := $(wildcard *.md)
OUTPUTS := $(patsubst %.md,%.html,$(INPUTS))

%.html: %.md
	pandoc $< -o $@

build: $(OUTPUTS)
	echo "done"
