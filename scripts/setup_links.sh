#!/bin/bash

echo "Welcome to my linking script !"

ln -si ~/.config/other_dotfiles/.zshrc ~/.zshrc
ln -si ~/.config/other_dotfiles/.gitconfig ~/.gitconfig
ln -si ~/.config/other_dotfiles/.emacs ~/.emacs

read -p "Creating greeter user ? [y/N]" yesno
if [ "$yesno" = "y" ]
then
  sudo useradd greeter 
fi

echo "Add samuel to video..."
sudo usermod -a -G video samuel

echo "Enabling basic services..."
sudo systemctl enable dhcpcd bluetooth iwd greetd

echo "Linking greetd"
sudo mkdir -p /etc/greetd
sudo ln -i ~/.config/other_dotfiles/greetd/* /etc/greetd/

echo "Bluetooth..."
sudo ln -i ~/.config/other_dotfiles/bluetooth/main.conf /etc/bluetooth/main.conf 

echo "To configure eduroam, manually copy the file to /var/lib/iwd/eduroam.8021x and edit the password."

# To fix iwd at startup ; 
# https://wiki.archlinux.org/title/Iwd#Restarting_iwd.service_after_boot
