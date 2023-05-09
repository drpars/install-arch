#!/bin/bash

# Kernel
pacman -S --needed --noconfirm linux-zen linux-zen-headers
# Command line tools - utilities
pacman -S --needed --noconfirm xdg-utils coreutils util-linux procps-ng exa pacman-contrib bash-completion usbutils dialog haveged
# User directories
pacman -S --needed --noconfirm xdg-user-dirs
# Compression tools
pacman -S --needed --noconfirm zip unzip unrar p7zip lzop tar
# Network                                                                 
pacman -S --needed --noconfirm samba nfs-utils bind
# Bluetooth
pacman -S --needed --noconfirm bluez bluez-utils
# File-system #gvfs-afc gvfs-gphoto2 gvfs-google
pacman -S --needed --noconfirm exfatprogs e2fsprogs dosfstools gvfs gvfs-mtp gvfs-smb gvfs-nfs
# Sound
pacman -S --needed --noconfirm pipewire pipewire-alsa pipewire-pulse pipewire-jack
# Multimedia 
pacman -S --needed --noconfirm gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gst-plugin-pipewire gst-libav libde265
# Printer
pacman -S --needed --noconfirm cups cups-pdf cups-filters libcups
# XOrg
pacman -S --needed --noconfirm xorg-server xorg-server-common xorg-xinit xorg-xwayland xorg-xcursorgen
# Fonts
pacman -S --needed --noconfirm ttf-hack-nerd ttf-dejavu ttf-droid gnu-free-fonts ttf-liberation ttf-roboto ttf-anonymous-pro ttf-cascadia-code ttf-opensans noto-fonts noto-fonts-emoji xorg-fonts-type1 ttf-ubuntu-font-family
# Man Pages
pacman -S --needed --noconfirm man-db man-pages
# Others
pacman -S --needed --noconfirm nvme-cli
pacman -S --needed --noconfirm acpi acpi_call

systemctl enable haveged
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable fstrim.timer
