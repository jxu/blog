# Simpler Bash Prompt

On Ubuntu, the default bash prompt is given in ~/.bashrc: 

    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

Aside from a [fancy chroot trick](https://askubuntu.com/a/372862), this produces a color prompt like

    jx@ThinkPad-P51:~/mydir$ 

This is fine, but one thing I've always disliked is that if I'm in a deep directory, the commands could start all the way at the right side of the screen:

    jx@ThinkPad-P51:~/really_long_directory/more/nested/directory$ echo 'hi'

Plus, the hostname is redundant on my personal computer, as I know where I'm logged into. 

I was inspired by Git Bash Shell on Windows(!) to start the command on a new line, always left-justified. This makes it easier to visually keep track of the command history. Keeping the bold green working directory from the original prompt, I used https://bash-prompt-generator.org to generate a PS1 simplified as 

    PS1='\[\e[32;1m\]\w\[\e[0m\]\n\$ '

This produces a simple prompt like

    ~/really_long_directory/more/nested/directory
    $ echo 'hi'

On remote shells without color, this can be simplified even more to

    PS1='\w\n$ '

which is easy enough to remember. Bash also has a fancy option to only show trailing directories with `PROMPT_DIRTRIM`, like in Termux:

    ~/.../movies/old $ 

I didn't bother with this since I start on a new line.
