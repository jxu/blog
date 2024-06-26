# Downloading Panopto Videos 

My university frequently uses Panopto for recording class lectures. This has its advantages, namely that the recording of the professor and the slides are synced up, and you can search through the video by individual slide. However there is no option to download videos like with youtube-dl (there is an [old PR from 2017](https://github.com/ytdl-org/youtube-dl/pull/13449)).

Since the video is playing in the browser, there must be a way to extract video frames (and as a last resort there is always the "analog loophole", i.e. recording the screen), but Panopto could've made it difficult with a weird custom implementation of streaming video. Fortunately they did not and went with a standard solution.

My first thought was to play through parts of the video and see what shows up in Chromium network analyzer. 

![panopto network](panopto_network.png)

After the initial flurry of activity downloading all the normal website stuff, the main data being downloaded were clearly chunks of video numbered in order, such as `00058.ts`. These are MPEG transport stream files, each about 1.1 MB. There are two video streams: one for recording and one for slides. Everything below that applies to one stream also applies to all others. To make sure I didn't miss anything, I dumped the network monitor resource loading list as a HAR file (JSON format) and looked through it manually. Along with the video stream data, there are M3U playlists that organize the chunks of video. Here is `master.m3u8` which points to the M3U playlist of each video resolution:

```
#EXTM3U
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=844601,CODECS="avc1.4d002a,mp4a.40.2",RESOLUTION=856x480,CLOSED-CAPTIONS=NONE
745737/index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=538373,CODECS="avc1.4d002a,mp4a.40.2",RESOLUTION=600x338,CLOSED-CAPTIONS=NONE
439509/index.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=385266,CODECS="avc1.4d002a,mp4a.40.2",RESOLUTION=424x240,CLOSED-CAPTIONS=NONE
286402/index.m3u8
```

I used the highest resolution, corresponding to the first `index.m3u8`:

```
#EXTM3U
#EXT-X-PLAYLIST-TYPE:EVENT
#EXT-X-TARGETDURATION:10
#EXT-X-VERSION:3
#EXT-X-MEDIA-SEQUENCE:0
#EXTINF:9.0067333,
00000.ts
#EXTINF:9.0067444,
00001.ts
#EXTINF:8.9899111,
00002.ts
...
#EXTINF:9.0067444,
00482.ts
#EXTINF:9.0067445,
00483.ts
#EXTINF:5.3769732,
00484.ts
#EXT-X-ENDLIST
```

This confirms that the stream files, each almost exactly 9 seconds long, are played in numerical order, and tells me `00484.ts` is the final file. Now I can use a simple shell loop to download these files, which I have access to since the current session hasn't expired yet. (Actually, if the numbers are out of range in this loop, wget returns a 403 error code and doesn't download anything, so we can also learn the total number of files this way.)

```bash
for n in {00000..00500}; do 
    wget https://d2y36twrtb17ty.cloudfront.net/sessions/a9133ca3-ba3d-483e-87cd-aab60120bbe5/4a588de5-fb14-4284-a81c-aab60120bbee-d08781d2-2293-4940-9d84-aab601406261.hls/745737/$n.ts; 
done
```

Finally, all the .ts files are combined together with ffmpeg. 

```bash
for i in {00000..00484}; do echo file \'$i.ts\' >> all_list.txt; done
ffmpeg -f concat -i all_list.txt -c copy all.ts
ffmpeg -i all.ts -c copy all.mp4
```

For recording there was only one error about timestamps but for screen there were many errors about timestamps. None of the errors appeared to affect playback.

Here's a screenshot of the combined recording video, showing Professor Randal Bryant telling a class of new 213 students on their first day about the danger of out-of-bounds memory accesses.

![panopto full video](panopto_full_video.png)

---

**2020 Update:** I found through googling that fellow CMU student Jacob Strieb has a much better way of downloading Panopto videos, namely using Panopto's folder RSS feed which contains a very convenient direct link to the mp4 video! 
This is described in the README of his script [panopto-download](https://github.com/jstrieb/panopto-download). The script extracts links and titles from the RSS XML file, enabling easy bulk downloading by piping to wget or curl. Very nice solution that few students seem to know about.




