#!/bin/bash

#----------------pacman-------------------------------------
sed -i '/#Color/s/^#//g' /etc/pacman.conf
sed -i '/#VerbosePkgLists/s/^#//g' /etc/pacman.conf
sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 3/g' /etc/pacman.conf
#acivate multilib repository
sudo sed -i '93s/.//' /etc/pacman.conf
sudo sed -i '94s/.//' /etc/pacman.conf
pacman -Sy
#-----------------------------------------------------------
