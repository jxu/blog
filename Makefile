# Idea to turn building blog into make...
# https://til.jakelazaroff.com/make/build-all-files-with-a-given-extension/

postsdir := posts
htmldir  := html

infiles  := $(wildcard $(postsdir)/*.md)
outfiles := $(patsubst $(postsdir)/%.md,$(htmldir)/%.html,$(infiles))

$(htmldir)/%.html: $(postsdir)/%.md
	mkdir -p $(htmldir)
	# pandoc -s for standalone HTML
	pandoc -f gfm $< -o - | \
	sed 's/\.md/\.html/g' | \
	{ cat header.html && cat; } > $@
	
build: $(outfiles)
