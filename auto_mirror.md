# Automatic backup mirroring

In the past few years I've been neglecting making backups, which obviously shows the issue with manual backups. Previously I had a small rsync script that copied my home directory to an external drive. I had the idea of connecting my external drive to my laptop dock permanently, so I could do automated backups. Backups off-site (to the cloud) are more ideal, but this is pretty decent and doesn't cost me anything.

Instead of messing around with incremental or differential backups, which I find cool, the simple solution for now is to mirror my files to a backup that is always "latest". This will save me if my hard drive dies, but not if I accidentally deleted a file a month ago. This is achieved with rsync's `--delete`, which can delete files at the destination (the default is to never delete anything). I'm also experimenting with setting up a systemd timer to run the backup every week or month. Sending a desktop notification on success or failure is even fancier, but for now I'll just keep temporary systemd journal logs.
 
