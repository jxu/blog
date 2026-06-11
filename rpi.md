# RasPi and Lil NAS

Recently I remembered I had a Raspberry Pi Zero W I bought several years ago, before the whole chip shortage when the prices skyrocketed to GPU-levels of inflated. (Even before I never saw it at the supposed $10 base price.) I set it up as a Pi-hole in 2023 for my home's local network, but it ended up being useless since it can't block youtube ads which come from the same domain, what a client-side extension like uBlock Origin can do.

The Pi Zero itself is quite small and minimal, having only three thin inconvenient ports: USB power, USB micro-B, and mini-HDMI. All require an adapter, and the kit I bought had all of them. I couldn't find the HDMI one but I did dig up the micro-B cable. I believe when I first got the board, I used our home TV as an easy HDMI monitor and the one USB port for a keyboard to set up Raspbian.

Here's some trivia: The chip is a [Broadcom BCM2835](https://elinux.org/RPi_Hardware#Components), a single-core 32-bit [ARM11](https://en.wikipedia.org/wiki/ARM11) SoC with 512 MB RAM and integrated video core. This is actually the same chip as the original RPi 1 models, but clocked at 1 GHz instead of 700 MHz. I wondered how this 2012 chip compared to my Wii, which was released in 2006. Its [codename Broadway processor](https://en.wikipedia.org/wiki/Broadway_(processor)) was actually 32-bit PowerPC run at about 729 MHz, with a very measly 88 MB total RAM. It [supposedly](https://www.neogaf.com/threads/console-power-theoretical-peak-performances-in-flops-single-precision-floating-point-operations-per-second-fp32.1533438/) had a theoretical peak of 8.8 CPU GFLOPS and 12.2 GPU GFLOPS. The RPi supposedly has [2.4 CPU GFLOPS](https://boinc.bakerlab.org/rosetta/cpu_list.php) and [24 GPU GFLOPS](https://github.com/hermanhermitage/videocoreiv/wiki/VideoCore-IV---BCM2835-Overview) (where most of the compute power comes from), so in this very unscientific comparison beats the Wii, but not by much.

The last time I used the RPi, pi-hole started up automatically on boot. I forgot which IP it used, so I used `nmap -p 22 --open 192.168.1.0/24` to find 192.168.1.201.
Afterwards I found my browser had the pi-hole admin page in history, and (automatically set up?) rpi0w.local also works.

Embarassingly, I also couldn't remember the password, and I tried a bunch.
Fortunately, having physical access to Pi meant I could modify any file. I tried [several methods](https://raspberrypi.stackexchange.com/questions/4409/how-do-i-change-recover-my-password) to avoid reinstalling the OS image.
Editing `/etc/passwd` had no effect.
Editing `cmdline.txt` with `init=/bin/sh` didn't work, but I probably mounted it wrong. Such a hack also unsurprisingly interfered with normal bootup. 
Funnily enough, copying my public key to `~/pi/.ssh/authorized_keys` worked fine and let me SSH in where I could reset the password.

The original plan was to connect my external HDD via the USB port to use as a small backup server, or "Lil NAS" (with no redundancy itself).
The external drive is mounted at `/mnt` but not setup to do so at boot yet.
The downside is transfer speed is limited by rpi's wireless chip to about max 3 MB/s.
The backup is only a latest sync of my home directory, so thanks to rsync only 2 GB needed to be transferred in the most recent sync.

Ultimately I'm not satisfied with having a single drive for storage, as I've had one external drive fail on me in the past. Well, I idiotically kept it in my backpack for a while jostling and tumbling it around, but any drive, SSD or HDD, can randomly fail over time. 
The minimum safe solution is to have two drives, where one is a main storage server and the other is simply a backup copy. That would be a little bit complicated to setup and then monitor, as either two drives connected or buying a true home NAS. 

The safer/easier solution is to use cloud backup like AWS S3, which I trust has the competence to not lose my data. Their current pricing is $0.0023 per GB per month, so $2.3/mo for 100 GB or $23/mo for 1 TB. In theory S3 Glacier would be much cheaper for storage but much more expensive for retrieval, as it is intended for true archival stuff that will likely never be accessed again 
(Like my [favorite ending scene of *Raiders of the Lost Ark*](https://www.youtube.com/watch?v=FRP0MBNoieY), where "top men" have the Holy Grail boxed up and sent to a massive military warehouse with millions of identical-looking boxes, never to be seen again.)
There's also Google Drive with 100 GB for $2/mo and 2 TB for $10/mo, so probably the cheapest simple cloud solution. Of course local storage is cheaper in the long run. 
This will probably be covered in a future blog post.
