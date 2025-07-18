# Automatic backup mirroring

In the past few years I've been neglecting making backups, which obviously shows the issue with manual backups. Previously I had a small rsync script that copied my home directory to an external drive. I had the idea of connecting my external drive to my laptop dock permanently, so I could do automated backups. Backups off-site (to the cloud) are more ideal, but this is pretty decent and doesn't cost me anything.

Instead of messing around with incremental or differential backups, which I find cool, the simple solution for now is to mirror my files to a backup that is always "latest". This will save me if my hard drive dies, but not if I accidentally deleted a file a month ago. This is achieved with rsync's `--delete`, which can delete files at the destination (the default is to never delete anything). 

Update: I also set rsync to run weekly through a systemd service and timer. This was my first time setting up anything with systemd, and it worked out pretty smoothly. Systemd is also more robust with testing and logging. I even setup a fancy desktop notification with `notify-send` to indicate whether the backup run succeeded or failed. Overall, a very good learning experience. 
 
