# Recovering a Crouton Backup

The story starts with a silver Seagate external HDD lying in one of my drawers. 
Vaguely I remember it containing NTFS Windows-related contents: A full backup of my old Win8 desktop and other misc. stuff, including a few files saved from when I dual-booted Windows on my Thinkpad and the contents of a [TestDisk](https://www.cgsecurity.org/wiki/TestDisk) recovery.
That was using TestDisk to recover most of a different WD external HDD that had disk reading errors and then died, probably from all the jostling and dropping when I foolishly had it in my backpack in college (a story for another blog post, but suffice it to say an SSD would've been much safer).

One of the interesting folders in this recovery was `chromebook/`, which contained a single 7.5 GB file `trusty-20160602-1213.tar`.

Some background: in high school, our school district decided everyone needed Chromebooks (and we were all forced to pay $300 or something for this Google nonsense).
These Google products run Chrome OS, a locked-down glorified Chrome browser interface with all the Google apps like the Chrome browser, Gmail, Google Docs, Google Drive, etc replacing normal computer programs. 
Of course, being a bored high school student, I was always looking for ways around the limitations of the sandbox and a way to run a general linux laptop. 
Back then, the way to do this was with a set of scripts called [crouton](https://github.com/dnschneid/crouton), which stands for "_ChRomium Os Universal chrooT envirONment_ ...or something like that". 
It works actually using a [chroot](https://wiki.archlinux.org/title/Chroot), because ChromiumOS is based on Gentoo Linux.
To install, developer mode is needed, which involves physically removing the write-protect screw from inside the back. 
I was surprised it was this easy, as usually locked-down devices require a master password, signing key, or something you don't just give away to naughty kids. 
The screw is not even a proprietary one like you'd find in mobile devices or bathroom stalls, just a standard Phillips head. 

Anyway, the file size and naming suggested this was a crouton backup dump. 
If I backed up a system, I would only back up my own data (mostly in `/home`) and skip the system directories, and I remember I didn't have that much actual personal data on there. 
I would use yyyymmdd naming for backups, but I would never put the time, which the "1213" part seems to be. 

Untarring revealed a bunch of directories named `ECRYPTFS_FNEK_ENCRYPTED.*` and two files named `.ecryptfs` and `.crouton_targets`. 
Unfortunately I must've set up the chroot with encryption for whatever reason, so I would have to guess my old passwords. 
I knew I had nothing really of value in the files, but I took it upon myself as a challenge to try to decrypt the backup anyhow.

This [reddit comment](https://www.reddit.com/r/Crouton/comments/6wnt8l/comment/dmal8u2/) gave a hint about using either crouton or ecryptfs-utils directly to decrypt the [eCryptfs filesystem](https://wiki.archlinux.org/title/ECryptfs).
(The crouton repo was actually archived in August of this year as EOL.) 
Trying to run the [`crouton -f`](https://github.com/dnschneid/crouton?tab=readme-ov-file#a-backup-a-day-keeps-the-price-gouging-data-restoration-services-away) installer directly complains about not running on Chromium OS, as it assumes you are trying to restore a chroot on a Chromebook. 
The `edit-chroot -r -f` script looked promising, but all it did was untar the tarfile to the `$CHROOTS` directory.
The real command was [`mount-chroot`](https://github.com/dnschneid/crouton/blob/master/host-bin/mount-chroot). 
At first it complained about not finding a root password with `chromeos-setdevpasswd`, so I commented that out. 
Then it prompted for the encryption passphrase for trusty, which I guessed correctly. 
At this point it seems the decryption had worked, but it gave a puzzling error of "keyctl_session_to_parent: Operation not permitted" when trying to mount.

At this point, I was also separately trying to use `ecryptfs-recover-private` directly on the directory, but I didn't have a hex "mount key". 
In the `mount-chroot` bash script, there is some process of taking a "wrapped key" and writing it to `.ecryptfs` file, which doesn't match ecryptfs-tools which expects a file like `~/.ecryptfs/wrapped-passphrase`. 
Taking a hex dump of `.ecryptfs` shows a sequence of 16 bytes of ASCII characters that look like hex digits, but the mount key needs to be 32 hex digits.

I didn't feel like trying to massage the keys to the right form of ecryptfs-utils and thought it was more promising to continue trying the crouton scripts. 
The keyctl_session_to_parent error appears to have to do with sudo and calling process ownership, but I can't run `edit-chroot` without sudo. Somehow by running `keyctl new_session` commands outside the script, the error message disappeared. 

The next day after some experimentation, I discovered the script had actually succeeded, and using the `-p` flag printed out where it actually mounted to: `/run/crouton/home/jx/crouton/crouton/chroots/trusty`. 
So what was in this filesystem? Well, as I expected, nothing of note. 
It was a full chroot dump of a Trusty Ubuntu system. 
Some misc. downloaded files, git repos of projects I was working on at the time (all safe on Github), and a Stepmania installation so I could show off playing the game on my Chromebook at lunchtime (with bad input lag). 
But at least I got the satisfaction of seeing my backup without restoring to a physical Chromebook (or Chrome OS). 
Now I can safely delete it all, cleaning up a small portion of the external drive.
