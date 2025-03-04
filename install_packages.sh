#!/bin/bash

core_packages=(
    hyprland
    hyprpolkitagent
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    kitty
    networkmanager
    pipewire
    wireplumber
    bluez
    qt5-wayland
    qt6-wayland
    greetd
    greetd-regreet
)

utils=(
    hyprlock
    hypridle
    hyprpicker
    hyprpaper
    waybar
    fuzzel
    swaync
    cliphist
    flatpak
    yazi
    vim
    nano
    thunar
    vscode
    gparted
)

extras=(
    steam
    discord
)

# install packages
all_packages=("${core_packages[@]}" "${utils[@]}")

sudo pacman -S --needed --noconfirm "${all_packages[@]}"

# fonts
sudo pacman -S --needed --noconfirm $(pacman -Ssq noto-fonts) ttf-jetbrains-mono-nerd

# yay setup
sudo pacman -S --needed --noconfirm git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
