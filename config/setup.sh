#!/bin/bash

#You can change any data in the related files, according to your own...

# Local - Time Settings (Turkish language - Time --> Istanbul)
./install-arch/config/tr_locale.sh
# Set hostname
./install-arch/config/hostname.sh
# User Settings
./install-arch/config/user.sh
# Personalization pacman installer
./install-arch/config/pacman.sh
# Boot install
./install-arch/config/boot.sh
# SSH Settings
./install-arch/config/openssh.sh
# ArchLinux installation
./install-arch/config/base.sh

systemctl enable NetworkManager

printf "%s\n" "Arch Install Completed" "You can rebbot system"
