# C Indent Styles

A long time ago, when I first started using C++, I had to decide on an indentation style. Eventually I settled on Allman style, because I liked the braces lining up vertically instead of way off to the right. In recent years, I've been reading a lot more C source code, like that of the linux kernel, glibc, GNU coreutils, bsdutils, etc. I've even been writing a little C. I never came across a single codebase that used Allman, as all were variations of "opening brace on the same line". I conducted a quick search of C projects I had heard about to see what indent styles were in common use. I only looked at one source file and assumed it was used consistently throughout the project.

Definitions I used (I didn't come up with these names):

- 1TBS: opening brace on the same line, closing brace on its own line
- K&R: same as 1TBS, but function opening brace gets its own line
- Allman: opening brace always gets its own line
- GNU: cursed style that puts braces halfway between indentation (??)

Here are the results:

- 1TBS: redis, micropython, sway, systemd, webview
- K&R: linux, obs-studio, ffmpeg, php-src, curl, tmux, jq, rufus, mpv, openssl, musl, zstd, nginx, openwrt, libsodium
- Allman: HandBrake, postgres, reactos, vlc, glfw
- GNU: bash, coreutils, glibc
- ???: ImageMagick

As you can see, K&R dominates. Allman style tends to be used in code with long function and variable names, as it makes it easier to find the opening brace. GNU is only used by GNU projects because it sucks. ImageMagick's is the weirdest I've ever seen, where code inside the opening and close braces gets indented 2 spaces, and then for if statements the code block with the braces gets indented again? I don't know but it's closest to GNU.

I'm experimenting with writing K&R, but I still haven't decided if I'll switch. I like saving the vertical space when scrolling through code, but I don't like the braces not lining up.
