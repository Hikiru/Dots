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
    ly
)

utils=(
    hyprlock
    hypridle
    hyprpicker
    hyprpaper
    swww
    waybar
    fuzzel
    swaync
    cliphist
    flatpak
    yazi
    neovim
    nano
    dolphin
    vscode
    gparted
)

extras=(
    steam
    discord
)

# install packages
all_packages=("${core_packages[@]}" "${utils[@]}" "${extras[@]}")

sudo pacman -S --needed --noconfirm "${all_packages[@]}"

# fonts
sudo pacman -S --needed --noconfirm $(pacman -Ssq noto-fonts) ttf-jetbrains-mono-nerd

# yay setup
sudo pacman -S --needed --noconfirm git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# systemctl service enabler
declare -A service_map=(
    ["networkmanager"]="NetworkManager"
    ["bluez"]="bluetooth"
    ["greetd"]="greetd"
    ["pipewire"]="pipewire pipewire-pulse"
    ["wireplumber"]="wireplumber"
)

for pkg in "${!service_map[@]}"; do
    if pacman -Qi "$pkg" &>/dev/null; then
        echo "Enabling services for $pkg: ${service_map[$pkg]}"
        sudo systemctl enable ${service_map[$pkg]}
    fi
done
