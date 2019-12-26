#!/bin/bash

#check running as root
if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi

# check on dependancies
dpkg -s secure-delete &> /dev/null
if [ $? -eq 0 ]; then
    echo "secure-delete is installed!"
else
    echo "secure-delete is NOT installed!"
    exit 1
fi

dpkg -s busybox &> /dev/null
if [ $? -eq 0 ]; then
    echo "busybox  is installed!"
else
    echo "busybox is NOT installed!"
    exit 1
fi

dpkg -s udhcpc &> /dev/null
if [ $? -eq 0 ]; then
    echo "udhcpc  is installed!"
else
    echo "udhcpc is NOT installed!"
    exit 1
fi
KEYDIR="/usr/local/share/initram_sshd"
INITRAMTOOLS="/etc/initramfs-tools"

# sshd keys
mkdir -p "$KEYDIR"
touch "${KEYDIR}/authorized_keys"
chmod 600 "${KEYDIR}/authorized_keys"
ssh-keygen -q -N "" -t dsa -f "${KEYDIR}/ssh_host_dsa_key"
ssh-keygen -q -N "" -t rsa -f "${KEYDIR}/ssh_host_rsa_key"
ssh-keygen -q -N "" -t ecdsa -f "${KEYDIR}/ssh_host_ecdsa_key"
ssh-keygen -q -N "" -t ed25519 -f "${KEYDIR}/ssh_host_ed25519_key"

set -e

install -m755 -D hooks/pi4-sshd-wifi "${INITRAMTOOLS}/hooks/pi4-sshd-wifi"
install -m755 -D scripts/init-premount/wifi-sshd-udhcpc "${INITRAMTOOLS}/scripts/init-premount/wifi-sshd-udhcpc"
install -m755 -D scripts/init-top/sdmem "${INITRAMTOOLS}/scripts/init-top/sdmem"
install -m755 -D scripts/local-bottom/kill_wireless "${INITRAMTOOLS}/scripts/local-bottom/kill_wireless"

echo " "
echo "etc/initramfs-tools/initramfs.conf needs:"
echo "   BUSYBOX=y"
echo " "
echo " "
echo "if encrypting, make sure /etc/cryptsetup-initramfs/conf-hook has:"
echo "   CRYPTSETUP=y"
echo " and cryptsetup is installed :-)"
echo " "
echo "to build initramfs run:"
echo "   update-initramfs -c -k $(uname -r)"
echo " "
echo "also modify /boot/config.txt ( and if encrypting /boot/cmdline.txt)"
echo "e.g."
echo "head -1 /boot/config.txt: initramfs initrd.img-4.19.75-v7l+ followkernel"
echo " "
echo "head -1 /boot/cmdline.txt: cryptdevice=/dev/mmcblk0p2:pi4 console=serial0,115200 console=tty1 root=/dev/mapper/pi4 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait"
echo " and appropriate modifications to /etc/crypttab and /etc/fstab"

