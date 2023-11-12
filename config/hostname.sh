#!/bin/bash

read -rep "Enter hostname : " hstnme
read -n1 -rep "Hostname is $hstnme, do you want to continue ? (y,n) " confrm

if [[ $confrm =~ ^[Yy]$ ]]; then
  printf "%s\n" "$hstnme" | sudo tee /etc/hosts
  printf "%s\n" "$hstnme" | sudo tee /etc/hostname
else
  until [[ $confrm =~ ^[Yy]$ ]]; do
    echo "You have to enter hostname !"
    read -rep "Enter hostname : " hstnme
    read -n1 -rep "Hostname is $hstnme, do you want to continue ? (y,n) " confrm
  done
  printf "%s\n" "$hstnme" | sudo tee /etc/hosts
  printf "%s\n" "$hstnme" | sudo tee /etc/hostname
fi
