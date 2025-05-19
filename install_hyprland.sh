#!/bin/bash
echo "This will install my dotfiles to your system."
echo "You must only confirm your password once with this script."
echo "This requires root privledges to install packages. You will not be prompted for packages. This script is unnattended."
echo "This script assumes you use yay and pacman."

set -x
sudo -v

sudo pacman -S --needed python3 hyprland waybar imagemagick strawberry flatpak firefox curl zsh --noconfirm
yay -S --needed python-pywal16 visual-studio-code-bin opentabletdriver vesktop themix-gui themix-plugin-base16-git themix-theme-oomox-git --noconfirm

flatpak install flathub --system org.kde.krita org.kde.kdenlive -y

# NOT DONE
#read inpt -p "Do you want my [p]rograms or [j]ust the configs?" -n 1
#if [[ "$inpt" == "p" ]]; do
#    sudo pacman -S strawberry flatpak
#    yay -S visual-studio-code-bin
#

# Copy hyprland
mkdir -p $HOME/.config/hypr
cp hyprland/hypr $HOME/.config/ -rfv

# Copy wallpapers & scripts
mkdir -p $HOME/.config/colton-dfiles
cp wallpapers $HOME/.config/colton-dfiles -rfv
cp upgrade_system.sh $HOME/.config/colton-dfiles -rfv

# Copy waybar
mkdir -p $HOME/.config/waybar
cp hyprland/waybar $HOME/.config/waybar -rfv

# Copy wal templates
mkdir -p $HOME/.config/wal
cp hyprland/wal/templates $HOME/.config/wal -rfv

# Generate pywal colours
hyprland/hypr/scripts/cycle_wallpaper.sh

# Build oomox theme
oomox-cli \
  ~/.cache/wal/colors-oomox \
  --output wal_theme \
  --target-dir ~/.themes

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Change shell to zsh
chsh -s /usr/bin/zsh

# Copy ZSH files
cp hyprland/zsh/zshrc $HOME/.zshrc -fv
cp hyprland/zsh/custom $HOME/.oh-my-zsh -rfv

sudo -K

set +x
echo "Press any key to quit..."
read -n 1
