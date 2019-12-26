# initramfs-tools-pi4
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
