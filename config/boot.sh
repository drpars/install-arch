#!/bin/bash

# Systemd-Boot

pacman -S --needed --noconfirm efibootmgr edk2-shell
cp /usr/share/edk2-shell/x64/Shell.efi /efi/shellx64.efi

bootctl --esp-path=/efi --boot-path=/boot --efi-boot-option-description="Arch Linux" install

mkdir -p /efi/loader/entries
cat > /efi/loader/loader.conf << EOF
default  arch.conf
timeout  menu-force
console-mode 0
EOF
touch /boot/loader/entries/arch.conf
cat >> /boot/loader/entries/arch.conf << EOF
title   Arch Linux
linux   /vmlinuz-linux-zen
initrd  /intel-ucode.img
initrd  /initramfs-linux-zen.img
options root=LABEL=Root rw rootfstype=ext4 systemd.unit=graphical.target nvidia-drm.modeset=1 resume=UUID= resume_offset=
# 1--> root=PARTUUID= , 2--> resume=UUID= , 3--> resume_offset=
EOF

# Adds a pacman hook which is executed every time systemd is upgraded.
cat > /etc/pacman.d/hooks/95-systemd-boot.hook << EOF
[Trigger]
Type = Package
Operation = Upgrade
Target = systemd

[Action]
Description = Gracefully upgrading systemd-boot...
When = PostTransaction
Exec = /usr/bin/systemctl restart systemd-boot-update.service
EOF