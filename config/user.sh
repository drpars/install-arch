#!/bin/bash

# Change 'pass' and 'user' to whatever password you want to use

echo root:pass | chpasswd
useradd -m -G wheel user
echo drpars:pass | chpasswd
sed -i '/# %wheel ALL=(ALL:ALL) ALL/s/^# //g' /etc/sudoers
