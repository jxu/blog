---
layout: post
title:  Trying to Unlock and Install Custom ROM for Huawei P10 Lite
category: phone
description: It's never as easy as it looks on XDA. 
---

# Introduction

I've had my trusty Samsung Galaxy S5 for 4 years, but already by 2017 it was clear its time as my everyday phone was coming to an end. The screen was cracked even with a protective case, the AMOLED screen flickered bright green when the brightness was set too low, and the small piece of plastic covering the charging port broke off. In picking a new phone, I decided to get a different type of phone: while the Galaxy S5 had been a higher-end phone ($650 then, compare nowadays flagship phones from $700 to $1000), the Huawei P10 Lite is in the category of cheaper Android phones, with decent specs (definitely enough for everyday use) at a much lower price of about $250 at the time ($200 now).

In retrospect, this decision was marred by some annoyances: the pervasiveness of EMUI, Huawei's shameless iOS knockoff that is a pain to update and also related to firmware, and such critical to what ROMs can be installed; and more importantly, Huawei's decision to stop giving out bootloader unlock codes in mid 2018, just before I purchased and received my phone, which is the crucial key to flashing a recovery and installing a ROM. This move by Huawei was widely panned by XDA commenters (see [comments on an XDA news article](https://www.xda-developers.com/huawei-honor-request-bootloader-unlock-code/)). TheCardinal sums it up best: 

> You shouldn't be required to pay to unlock your own device

If I wanted a closed ecosystem, I would buy an iPhone; needless to say, I won't be buying another Huawei phone. Nonetheless, it was still an Android phone, and had the potential to support ROMs. 


# Obtaining the Bootloader Code

The first step is installing HiSuite and USB phone drivers. I don't know if this is strictly necessary, but I recall adb not seeing my device. HiSuite is a useless phone manager system, maybe akin to Samsung Kies. Native Linux support? Forget it. I also took a backup through HiSuite, though of course being the useless piece of software it is, that backup ended up not being able to be restored. 

**The most important thing to do when flashing recovery or ROMs is to take a full backup of the device, preferably through TWRP.** I cannot stress this enough; I have been saved countless times by TWRP backups, and burned a few times when I didn't have a backup. This time around, I should've taken a full backup in TWRP after having flashed TWRP, but I thought bootloader unlock does a factory reset, so I may not have been able to do a TWRP backup. I backup all my text messages, all my photos/videos are on a SD card, and naturally DropBox, Gmail, etc. stuff is online, so nothing personal was lost.

Fortunately, it is still possible to get bootloader codes from third-party sources. The two I know of are [FunkyHuawei](https://funkyhuawei.club/bootloader) and [DC Unlocker](https://www.dc-unlocker.com/). FunkyHuawei charges $55 USD, which is far too much, so I went with DC Unlocker, which provides a convenient program (only tested on Windows) an unlock code for the much more reasonable €4. 

The unlocking process is as follows: Type `*#*#2846579#*#*` into the dial pad and put phone into Manufacture mode (Background settings > USB ports settings > Manufacture mode). Check that `adb device` lists the phone and DC Unlocker finds the phone.

Now you can spend your 4 credits to receive the unlock code from DC Unlocker's server. The first time I tried this I got a server error and support was on winter holiday, but I tried it again the next day and I received my 16-digit unlock code, to my delight.

# Flashing Recovery and ROM 

The next step is to flash TWRP as recovery. This is done by first checking `adb devices` lists the phone as "device", not "unauthorized" (enable USB debugging through developer settings if necessary). Reboot into fastboot "FASTBOOT&RESCUE MODE" with `adb reboot bootloader` or by powering on the phone holding the power button + volume down. The real magic in unlocking the bootloader is done with `fastboot oem unlock [unlock code]`. Now the phone restarts and so usb debugging needs to be re-enabled. Installing [TWRP OpenKirin edition](https://forum.xda-developers.com/huawei-p9lite/development/twrp-t3588356) with `fastboot flast recovery twrp.img` worked like a charm. (This may have been the wrong TWRP. I elaborate on this later)

At this point I tried to install a ROM, but with no success. My phone was on EMUI 5.1, so I could only use ROMs based on EMUI 5.x: [LineageOS 14.1 by HassanMirza01](https://forum.xda-developers.com/p10-lite/development/rom-lineageos-14-1-p10-lite-t3743220), [Ressurection Remix by Meticulus](http://www.meticulus.co.vu/p/ressurection-remix-for-hi6250-devices.html), [Elemental V4 by KingOfMezi](https://forum.xda-developers.com/p10-lite/development/rom-emui-5-1-huawei-p10-lite-dual-sim-t3733095), to name a few. 

Here is where I ran into extreme difficulty. I could not get any of the ROMs to get past the booting screen. I still don't know what the issue is. One important quirk is that the data partition is encrypted, and so must be completely formatted as f2fs. [As Meticulus writes:](http://www.meticulus.co.vu/p/hi6250-custom-rom-installation.html)

> The stock ROM uses encryption on the /data partition. So on that partition there is a master key for decrypting the data on it. I have not found a way to get custom ROMs to decrypt it so it has to be formatted. Now, in order to get back to stock properly that "master key" needs to be put back. The only way I know to do that is to do a raw dump of a PURE stock system partition along with the kernel. That way, if you want to get back to stock, you just dump the PURE stock system image and kernel back to their partitions and wipe the /data partition. When you boot up after doing that, stock will fix the data partition and put the "master key" back.

Even worse, I was stuck in a reboot loop, no matter what I did. I thought it first it was SuperSU, since that has caused me some issues in the past, but even without it no ROM would install and boot properly. I tried the [dload method to install Huawei's own updates](https://www.getdroidtips.com/full-guide-install-stock-firmware-huawei-smartphone/) but of course this didn't work. I was stuck in ROM limbo. The only things that did work were TWRP and flashing recovery through fastboot. 

Fortunately, [KingOfMezi has a compilation of TWRP-flashable P10 Lite EMUI 5.1 firmwares, for all models](https://forum.xda-developers.com/p10-lite/development/compilation-firmware-flasheables-huawei-t3736754). I could flash the zip and update.zip for my WAS-LX3 (Latin America version) phone and successfully run the stock firmware. However, this version had severe hardware issues, with camera, microphone, and speakers not working. The screen, WiFi, 4G, and texts still worked, which on the bright side is a large part of the functionality of any smartphone. 

I was not satisfied with this reduced functionality. I still had full access to TWRP and fastboot so I could try more things. I eventually fixed all the functionality of the stock image by using KingOfMezi's custom TWRP he linked in the compilation page instead of OpenKirin's. Finally my phone was back to a stock state and fully usable, so a big thank you to him.


# Conclusion

I have not updated the build of stock EMUI or tried out any other ROMs since restoring to stock. I am experimenting with a refurbished Samsung Galaxy S8, which still holds up well in specs even as the flagship S9 is out. So in Samsung land it'll be back to Odin and Heimdall, however the US version which I got does not have an unlocked bootloader, which is very problematic (that is an adventure for a different post). I may switch phones to get a more ROM friendly and less Apple-ish manufacturer than Samsung, and keep the P10 Lite for now. My parents have expressed interest in having a secondary phone, and selling it on eBay currently will only net optimistically $100. With the new TWRP, I may still try to install a ROM. 
