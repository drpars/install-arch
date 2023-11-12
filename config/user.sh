#!/bin/bash

if [ $(id -u) -eq 0 ]; then
  read -n1 -rep "Do you want to create user ? (y/n) " answr
  if [[ $answr =~ ^[Yy]$ ]]; then
    # Root password
    read -s -rep "Enter the root password    : " passroot
    read -s -rep "Re-enter the root password : " passrootcheck
    if [[ $passroot == $passrootcheck ]]; then
      echo root:$passroot | chpasswd
      echo "The root password has been successfully created."
    else
      until [[ $passroot == $passrootcheck ]]; do
        echo "Passwords didn't match. Try again..."
        read -s -rep "Enter the root password    : " passroot
        read -s -rep "Re-enter the root password : " passrootcheck
      done
      echo root:$passroot | chpasswd
      echo "The root password has been successfully created."
    fi
    # User add
    read -n1 -rep "Would you like to add a user ? (y/n) " createuser
    if [[ $createuser =~ ^[Yy]$ ]]; then
      echo "Please make sure you have entered the correct username and password."
      # User name
      read -rep "Enter username : " addusername
      read -n1 -rep "User name is $addusername. Do you want to continue ? (y/n) " addusernamecheck
      if [[ $addusernamecheck =~ ^[Yy]$ ]]; then
        useradd -m $addusername
        echo "$addusername created successfully."
      else
        until [[ $addusernamecheck =~ ^[Yy]$ ]]; do
          echo "Re-enter username"
          read -rep "Enter username : " addusername
          read -n1 -rep "User name is $addusername. Do you want to continue ? (y/n) " addusernamecheck
        done
        useradd -m $addusername
        echo "$addusername created successfully."
      fi
      # User password
      read -s -rep "Enter password    : " adduserpasswrd
      read -s -rep "Re-enter password : " adduserpasswrdcheck
      if [[ $adduserpasswrd == $adduserpasswrdcheck ]]; then
        echo $addusername:$adduserpasswrd | chpasswd
        echo "User password created successfully."
      else
        until [[ $adduserpasswrd == $adduserpasswrdcheck ]]; do
          echo "Passwords didn't match. Try again..."
          read -s -rep "Enter password    : " adduserpasswrd
          read -s -rep "Re-enter password : " adduserpasswrdcheck
        done
        echo $addusername:$adduserpasswrd | chpasswd
        echo "User password created successfully."
      fi
      # Superuser
      read -n1 -rep "Do you want to define superuser authority for $addusername? (y/n) " addsu
      if [[ $addsu =~ ^[Yy]$ ]]; then
        sed -i '/# %wheel ALL=(ALL:ALL) ALL/s/^# //g' /etc/sudoers
        gpasswd -a $addusername wheel
        echo "$addusername created with superuser privilege."
      else
        echo "superuser privilege not defined."
      fi
    else
      echo "No users have been added"
    fi
  else
    echo "User actions have been cancelled."
  fi
else
  echo "Only root may add a user to the system."
fi
