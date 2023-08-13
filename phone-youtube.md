# Using Youtube On My Phone

Youtube's app used to be my go-to for watching Youtube because the app seemed easier to use. However after an increase in very annoying ads and another UI change, I changed to watching Youtube on Firefox, which actually has most of the basic functionality of the app. Firefox is a nice browser that supports browser extensions, so I can use the well-known content blocker uBlock Origin. Seeing that "blocked since install" number is hugely satisfying. The most significant downside is the lack of 60 fps playback.

Also, it's easy to download videos from Youtube without using their stupid Youtube Premium service. I use this for watching videos when traveling or when I don't want to waste mobile data. All that's needed is the terminal environment [Termux](https://termux.com/) and the amazing video downloading tool [youtube-dl](https://github.com/ytdl-org/youtube-dl). 

1. Give termux access to phone's filesystem with `termux-setup-storage`

2. Install python and ffmpeg (for youtube-dl) with `pkg install python ffmpeg`
    
3. Install youtube-dl through pip with `pip install youtube-dl`
    
Now I can download videos and play them through any video player like VLC with

    cd storage/movies
    youtube-dl [VIDEO_URL]
    
Another tip: youtube-dl chooses the highest quality video by default. For long videos or 4k videos, this can lead to very large file sizes. Specifying format code 22 with `-f22` will select a 720p version with video and audio. This can be half the size of the 1080p version and a tenth the size of the 4k version, and usually better. As a small bonus, there is no need to wait for youtube-dl to download a separate audio stream and ffmpeg to mux the audio and video together.
