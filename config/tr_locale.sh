#!/bin/bash

# Turkish language

ln -sf /usr/share/zoneinfo/Europe/Istanbul /etc/localtime
hwclock --systohc --localtime

sed -i '/#tr_TR.UTF-8/s/^#//g' /etc/locale.gen
locale-gen

cat > /etc/locale.conf << EOF
LANG=tr_TR.UTF-8
EOF

cat > /etc/vconsole.conf << EOF
KEYMAP=trq
FONT=LatArCyrHeb-16
EOF

echo "PANTHERA-ARCH" > /etc/hostname
cat > /etc/hosts << EOF
PANTHERA-ARCH
EOF