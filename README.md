# initramfs-tools-pi4

Note: whilst this has been a good exercise in manipulating the initram, for me I'm coming to the
conclusion that just encrypting swap, tmp and home folder and moving any sensitive info to home
is far simpler and easier to maintain.  i.e. moving the pi to a different wifi network means
having to edit the wpa_supplicant conf on another computer for the new network - chroot using qemu (or have a 2nd unencrypted pi sd card and chroot)
then rebuild initramfs, keep fingers crossed then boot - scan for ip of pi then connect

Far easier to just be able to login as root, provide credentiatials to wpa_supplicant then restart the service
(all on pi - assumes have keyboard, if I don't then all I need to do is edit wpa_supplicant conf on laptop, no need for 
chroot or building initramfs) - anyway..... I might change my mind...again....


initram for pi4 with wifi
need cryptsetup (if encrypting), busybox, secure-delete, udhcpc

run `./install.sh` to install - hopefully this will work, not tested at this point

please read the scripts for details

note:
NOT using dropbear (using sshd instead)
USING udhhcpc for ip address - this could all be a lot simpler if just using static ip, but my usecase is for moving pi around and no access to router therefore dynamic ip.

lot's of additional configuration needed for encrypting - will add instructions to this readme later

you'll need to put authorized keys in */usr/local/share/initram_sshd/authorized_keys* so you can actually login

(preferably these aren't your machine keys - i.e create keys just for this purpose)


todo:
* write a decent readme!
* include instructions for encrypting
* any other config files that need adjusting
* references to sites where got inspiration
