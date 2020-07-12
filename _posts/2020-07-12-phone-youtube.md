---
layout: post
title:  Using Youtube On My Phone
category: phone
description: No more ads!
---

Youtube's app used to be my go-to for watching Youtube because the app seemed easier to use. However after an increase in very annoying ads and another UI change, I changed to watching Youtube on Firefox, which actually has most of the basic functionality of the app. Firefox is a nice browser that supports browser extensions, so I can use the well-known content blocker uBlock Origin. Seeing that "blocked since install" number is hugely satisfying.

Also, it's easy to download videos from Youtube without using their stupid Youtube Premium service. I use this for watching videos when traveling or when I don't want to waste mobile data. All that's needed is the terminal environment Termux and the amazing video downloading tool youtube-dl. 

1. Give termux access to phone's filesystem with `termux-setup-storage`

2. Install python and ffmpeg (for youtube-dl) with `pkg install python ffmpeg`
    
3. Install youtube-dl through pip with `pip install youtube-dl`
    
Now I can download videos and play them through any other app like VLC with

    cd storage/movies
    youtube-dl [video_url]
