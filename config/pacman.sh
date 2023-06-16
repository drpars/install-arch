#!/bin/bash

# pacman options
sed -i '/#Color/s/^#//g' /etc/pacman.conf
sed -i '/#VerbosePkgLists/s/^#//g' /etc/pacman.conf
sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 3/g' /etc/pacman.conf
# Acivate multilib repository
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
pacman -Sy
