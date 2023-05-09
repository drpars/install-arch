#!/bin/bash

# These are my personal settings for partitioning and etc. if it doesn't suit for you, you can change it.
# Partition the disk
# You can follow and read install-arch/config/base.sh file
# nvme0n1p1 -> /mnt/efi , nvme1n1p1=512M -> /mnt/boot , nvme1n1p2=64gb -> /mnt , nvme1n1p3=... -> /mnt/home
# swapfile -> 8GB

loadkeys trq
setfont LatArCyrHeb-16
sed -i '/#tr_TR.UTF-8/s/^#//g' /etc/locale.gen
locale-gen
export LANG=tr_TR.UTF-8
timedatectl set-timezone Europe/Istanbul
timedatectl set-ntp true
# pacman -Sy --needed --noconfirm archlinux-keyring
pacman-key --init
pacman-key --populate archlinux

# Partitioning
# mkfs.vfat -F32 -n SYSTEM /dev/nvme0n1p1
mkfs.vfat -F32 -n BOOT /dev/nvme0n1p2
mkfs.ext4 -L Root -F /dev/nvme0n1p3
mkfs.ext4 -L Home -F /dev/nvme0n1p4
# first mount root partition
mount /dev/nvme0n1p3 /mnt
mkdir -p /mnt/{efi,boot,home}
# other mountable partition
mount /dev/nvme0n1p1 /mnt/efi
mount /dev/nvme0n1p2 /mnt/boot
mount /dev/nvme0n1p4 /mnt/home

# Swap file
dd if=/dev/zero of=/mnt/swapfile bs=1M count=8192 status=progress
chmod 600 /mnt/swapfile
mkswap /mnt/swapfile
swapon /mnt/swapfile

chmod +x /install-arch/config/*.sh
pacstrap /mnt base base-devel linux linux-firmware intel-ucode neovim git networkmanager
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt ./install-arch/config/setup.sh
