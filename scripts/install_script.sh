#!/bin/bash

echo "Welcome to my installation script !"

essentialPackages=("base" "base-devel" "linux" "linux-firmware" "vi" "neovim" "efibootmgr" "dhcpcd" "iwd" "zsh" "sudo" "git" "lazygit" "openssh" "man" "curl")

desktopPackages=("sway" "alacritty" "firefox" "pipewire" "pipewire-pulse" "pavucontrol" "pamixer" "light" "seahorse" "xorg-xwayland" "bluez" "bluez-utils" "blueman")

mostPackages=("retroarch" "thunderbird" "deluge" "opam" "")

mostAURPackages=("sway-launcher-desktop" "rambox" "spotify-adblock-git" "bitwarden")

concatenate() {
  local -n arr=$1
  temp=""
  for s in "${arr[@]}"; do
    temp+="${s} "
  done
  echo "$temp"
}


read -p "Would you like to install the most essential packages ? [y/N] " yesno
if [ "$yesno" = "y" ]
then
  echo "[running] pacman -Syu --needed $(concatenate essentialPackages)"
  sudo pacman -Syu --needed $(concatenate essentialPackages)
fi

read -p "Would you like to install the basic desktop packages ? [y/N] " yesno
if [ "$yesno" = "y" ]
then
  echo "[running] pacman -Syu --needed $(concatenate desktopPackages)"
  sudo pacman -Syu --needed $(concatenate desktopPackages)
fi

read -p "Would you like to install most packages ? [y/N] " yesno
if [ "$yesno" = "y" ]
then
  echo "[running] pacman -Syu --needed $(concatenate mostPackages)"
  sudo pacman -Syu --needed $(concatenate mostPackages)
fi

# Installation of yay
read -p "Would you like to install Yay ? [y/N] " yesno
if [ "$yesno" = "y" ]
then
  echo "Installing yay..."
  sudo pacman -S --needed git base-devel
  cd /tmp && git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
fi


read -p "Would you like to install most AUR packages ? [y/N] " yesno
if [ "$yesno" = "y" ]
then
  echo "[running] yay -Syu --needed $(concatenate mostAURPackages)"
  yay -Syu --needed $(concatenate mostAURPackages)
fi



