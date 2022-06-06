#!/bin/bash

echo "Welcome to my installation script !"

essentialPackages=("base" "base-devel" "linux" "linux-firmware" "vi" "neovim" "efibootmgr" "dhcpcd" "iwd" "zsh" "sudo" "git" "lazygit" "openssh" "man" "curl" "htop" "tree")

desktopPackages=("sway" "alacritty" "firefox" "pipewire" "pipewire-pulse" "pavucontrol" "pamixer" "light" "seahorse" "xorg-xwayland" "bluez" "bluez-utils" "blueman" "ttf-nerd-fonts-symbols" "emacs" "otf-font-awesome" "waybar" "wl-clipboard" "nautilus" "xdg-user-dirs" "otf-font-awesome" "udiskie" "gnome-disk-utility")

mostPackages=("retroarch" "thunderbird" "deluge-gtk" "opam" "code" "imagemagick" "evince" "neofetch" "texlive-most" "biber" "steam" "discord" "dunst" "qt5-wayland" "xdg-desktop-portal" "vlc" "wine" "wine-mono" "wine-gecko" "lib32-libpulse" "sagemath" "sagemath-doc" "jupyter-notebook" "lua-language-server" "python-virtualenv" "fd" "python-pynvim" "zathura" "zathura-pdf-mupdf" "ttf-fira-code" "geogebra" "caprine")

mostAURPackages=("sway-launcher-desktop" "spotify-adblock-git" "bitwarden" "oh-my-zsh-git" "greetd" "greetd-gtkgreet" "alacritty-themes" "whatsapp-nativefier" "nvim-packer-git")

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

read -p "Would you like to enable multilib ? [y/N] " yesno
if [ "$yesno" = "y" ]
then
  sudo vi /etc/pacman.conf
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





