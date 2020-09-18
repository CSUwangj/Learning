# 二进制文件学习

本文形成于Ubuntu TLS 18.04下

## /bin

### bash

一个shell，全写Bourne-Again SHell，这部分就不展开叙述了，因为值得一篇专门的学习笔记。

### brltty

> BRLTTY is a background process (daemon) which provides access to the Linux/Unix
> console (when in text mode) for a blind person using a refreshable braille display.
> It drives the braille display, and provides complete screen review functionality.
> Some speech capability has also been incorporated.

大意是能驱动盲文显示器或者将输出转换成盲文的守护进程。居然还有这种东西，科技改变人生啊。  

### bunzip2

一个压缩文件的，压缩使用的 Burrows-Wheeler block sorting text compression algorithm 和 Huffman
coding。和 bzip2、bzcat、bzip2recover是一套工具。

```tldr
 - Compress a file:
   bzip2 {{path/to/file_to_compress}}

 - Decompress a file:
   bzip2 -d {{path/to/compressed_file.bz2}}

 - Decompress a file to standard output:
   bzip2 -dc {{path/to/compressed_file.bz2}}
```

### busybox

Linux系统中的瑞士军刀，其实也就是个工具集合，包含了各种常用工具。在我的环境中有以下应用：

```tldr
[, [[, acpid, adjtimex, ar, arp, arping, ash, awk, basename,
blkdiscard, blockdev, brctl, bunzip2, bzcat, bzip2, cal,cat, chgrp,
chmod, chown, chpasswd, chroot, chvt, clear, cmp, cp, cpio,crond,
crontab, cttyhack, cut, date, dc, dd, deallocvt, depmod,devmem, df,
diff, dirname, dmesg, dnsdomainname, dos2unix, dpkg,dpkg-deb, du,
dumpkmap, dumpleases, echo, ed, egrep, env, expand, expr,factor,
fallocate, false, fatattr, fdisk, fgrep, find, fold, free,
freeramdisk, fsfreeze, fstrim, ftpget, ftpput, getopt,getty, grep,
groups, gunzip, gzip, halt, head, hexdump, hostid, hostname httpd,
hwclock, i2cdetect, i2cdump, i2cget, i2cset, id, ifconfig,ifdown,
ifup, init, insmod, ionice, ip, ipcalc, ipneigh, kill,killall,
klogd, last, less, link, linux32, linux64, linuxrc, ln,loadfont,
loadkmap, logger, login, logname, logread, losetup, ls,lsmod,
lsscsi, lzcat, lzma, lzop, md5sum, mdev, microcom, mkdir,mkdosfs,
mke2fs, mkfifo, mknod, mkpasswd, mkswap, mktemp, modinfo,modprobe,
more, mount, mt, mv, nameif, nc, netstat, nl, nproc,nsenter,
nslookup, od, openvt, partprobe, passwd, paste, patch,pidof, ping,
ping6, pivot_root, poweroff, printf, ps, pwd, rdate,readlink,
realpath, reboot, renice, reset, rev, rm, rmdir, rmmod,route, rpm,
rpm2cpio, run-parts, sed, seq, setkeycodes, setpriv, setsid sh,
sha1sum, sha256sum, sha512sum, shred, shuf, sleep, sort,ssl_client,
start-stop-daemon, stat, static-sh, strings, stty, su,sulogin, svc,
swapoff, swapon, switch_root, sync, sysctl, syslogd, tac,tail, tar,
taskset, tee, telnet, telnetd, test, tftp, time, timeout,top,
touch, tr, traceroute, traceroute6, true, truncate, tty,tunctl,
ubirename, udhcpc, udhcpd, uevent, umount, uname,uncompress,
unexpand, uniq, unix2dos, unlink, unlzma, unshare, unxz,unzip,
uptime, usleep, uudecode, uuencode, vconfig, vi, w, watch,watchdog,
wc, wget, which, who, whoami, xargs, xxd, xz, xzcat, yes,zcat
```

### bzcat

见[bunzip2](#bunzip2)

### bzcmp -> bzdiff

对比bzip2压缩文件的

### bzdiff

同上

### bzegrep -> bzgrep

见[bzgrep](#bzgrep)

### bzexe

感觉像是压缩壳的感觉？

---
不是，而只是将程序压缩以后的数据放在了解密脚本后面。

### bzfgrep -> bzgrep

见[bzgrep](#bzgrep)

### bzgrep

在bzip2压缩文件上进行grep用

### bzip2

见[bunzip2](#bunzip2)

### bzip2recover

见[bunzip2](#bunzip2)，用于恢复受损的bzip2压缩文件

### bzless -> bzmore

bzip2压缩文件的less

### bzmore

bzip2压缩文件的more

### cat

```tldr
cat
Print and concatenate files.

 - Print the contents of a file to the standard output:
   cat {{file}}

 - Concatenate several files into the target file:
   cat {{file1}} {{file2}} > {{target_file}}

 - Append several files into the target file:
   cat {{file1}} {{file2}} >> {{target_file}}

 - Number all output lines:
   cat -n {{file}}

 - Display non-printable and whitespace characters (with
   M-
 prefix if non-ASCII):
   cat -v -t -e {{file}}
```

### chacl

改一个文件的ACL\(access control list\)的，比起chmod来说貌似支持单个用户的ACL修改?

自己做一个tldr：

```tldr

- An  ACL  that is not a minimum ACL, that is, one that specifies
  a user or group other than the file's owner or owner's group,
  must contain a mask entry:
  chacl u::rwx,g::r-x,o::r--,u:bob:r--,m::r-x file1 file2

- To set the default and access ACLs on newdir to be the same as
  on olddir, you could type:
  chacl -b `chacl -l olddir | \
    sed -e 's/.*\[//' -e 's#/# #' -e 's/]$//'` newdir

```

### chgrp

改文件所属组的

### chmod

改文件的模式位\(mode bits\)

### chown

该文件的所属人、所属组。

```tldr
Change user and group ownership of files and directories.

 - Change the owner user of a file/directory:
   chown {{user}} {{path/to/file_or_directory}}

 - Change the owner user and group of a file/directory:
   chown {{user}}:{{group}} {{path/to/file_or_directory}}

 - Recursively change the owner of a directory and its contents:
   chown -R {{user}} {{path/to/directory}}

 - Change the owner of a symbolic link:
   chown -h {{user}} {{path/to/symlink}}

 - Change the owner of a file/directory to match a reference file:
   chown --reference={{path/to/reference_file}} {{path/to/file_or_directory}}
```

### chvt

### cp

### cpio

### dash

### date

### dd

### df

### dir

### dmesg

### dnsdomainname -> hostname

### domainname -> hostname

### dumpkeys

### echo

### ed

### efibootdump

### efibootmgr

### egrep

### false

### fgconsole

### fgrep

### findmnt

### fuser

### fusermount

### getfacl

### grep

### gunzip

### gzexe

### gzip

### hciconfig

### hostname

### ip

### journalctl

### kbd_mode

### kill

### kmod

### less

### lessecho

### lessfile -> lesspipe

### lesskey

### lesspipe

### ln

### loadkeys

### login

### loginctl

### lowntfs-3g

### ls

### lsblk

### lsmod -> kmod

### mkdir

### mknod

### mktemp

### more

### mount

### mountpoint

### mt -> /etc/alternatives/mt

### mt-gnu

### mv

### nano

### nc -> /etc/alternatives/nc

### nc.openbsd

### netcat -> /etc/alternatives/netcat

### netstat

### networkctl

### nisdomainname -> hostname

### ntfs-3g

### ntfs-3g.probe

### ntfscat

### ntfscluster

### ntfscmp

### ntfsfallocate

### ntfsfix

### ntfsinfo

### ntfsls

### ntfsmove

### ntfsrecover

### ntfssecaudit

### ntfstruncate

### ntfsusermap

### ntfswipe

### open -> openvt

### openvt

### pidof -> /sbin/killall5

### ping

### ping4 -> ping

### ping6 -> ping

### plymouth

### ps

### pwd

### rbash -> bash

### readlink

### red

### rm

### rmdir

### rnano -> nano

### run-parts

### rzsh -> zsh

### sed

### setfacl

### setfont

### setupcon

### sh -> dash

### sh.distrib -> dash

### sleep

### ss

### static-sh -> busybox

### stty

### su

### sync

### systemctl

### systemd -> /lib/systemd/systemd

### systemd-ask-password

### systemd-escape

### systemd-hwdb

### systemd-inhibit

### systemd-machine-id-setup

### systemd-notify

### systemd-sysusers

### systemd-tmpfiles

### systemd-tty-ask-password-agent

### tar

### tempfile

### touch

### true

### udevadm

### ulockmgr_server

### umount

### uname

### uncompress

### unicode_start

### vdir

### wdctl

### which

### whiptail

### ypdomainname -> hostname

### zcat

### zcmp

### zdiff

### zegrep

### zfgrep

### zforce

### zgrep

### zless

### zmore

### znew

### zsh

### zsh5

## /usr/bin
