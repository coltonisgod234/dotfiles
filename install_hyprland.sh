#!/bin/bash
echo "This will install my dotfiles to your system."
echo "You must only confirm your password once with this script."
echo "This requires root privledges to install packages. You will not be prompted for packages. This script is unnattended."
echo "This script assumes you use yay and pacman."
echo "Your working directory MUST be the same folder that this script is located in or installation will FAIL!"
echo "You will be prompted for dotfile configuration options"
echo "You must run this script with bash and NOT zsh!"
set -x
sudo -v

function install_base_pkg () {
  sudo pacman -S --needed python3 hyprland waybar imagemagick wofi grim slurp hyprpaper hyprsunset curl kitty --noconfirm
  yay -S --needed python-pywal16 opentabletdriver vesktop themix-gui themix-plugin-base16-git themix-theme-oomox-git --noconfirm
}

function install_apps () {
  sudo pacman -S --needed pcmanfm strawberry firefox flatpak --noconfirm
  flatpak install flathub --system org.kde.krita org.kde.kdenlive -y
  yay -S visual-studio-code-bin --noconfirm
}

function prompt_apps () {
  set +x

  echo "Do you want my [a]pps or just the [b]ase packages?"
  read -n 1 do_you_want_the_apps_bitch 

  set -x

  if test "$do_you_want_the_apps_bitch" = "a"; then install_apps; fi
}

function copy_hyprland () {
  # Copy hyprland
  mkdir -p $HOME/.config/hypr
  cp hyprland/hypr $HOME/.config/ -rfv

  # Copy wallpapers
  mkdir -p $HOME/.config/colton-dfiles
  cp wallpapers $HOME/.config/colton-dfiles -rfv
  cp upgrade_system.sh $HOME/.config/colton-dfiles -rfv

  # Copy waybar
  mkdir -p $HOME/.config/waybar
  cp hyprland/waybar $HOME/.config/waybar -rfv

  # Copy wal templates
  mkdir -p $HOME/.config/wal
  cp hyprland/wal/templates $HOME/.config/wal -rfv
}

function gen_oomox_theme () {
  # Generate pywal colours
  hyprland/hypr/scripts/cycle_wallpaper.sh

  # Build oomox theme
  oomox-cli \
    ~/.cache/wal/colors-oomox \
    --output wal_theme \
    --target-dir ~/.themes

}

function shell_omz () {
  sudo pacman -S --needed --noconfirm zsh

  # Install oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  # Change shell to zsh
  sudo chsh -s "$(which zsh)" "$USER"

  # Copy ZSH files
  cp hyprland/zsh/zshrc $HOME/.zshrc -fv
  cp hyprland/zsh/custom $HOME/.oh-my-zsh -rfv
}

function stock_zsh () {
    sudo pacman -S --needed --noconfirm zsh
    # Change shell to zsh
    sudo chsh -s "$(which zsh)" "$USER"
}

function change_shell () {
  set +x

  echo -e "Which do you want?\n * [o]h-my-zsh (my current)\n * [s]tock ZSH\n * [D]o not change my shell"
  read -n 1 which_one

  set -x

  if test "$which_one" = "o"; then shell_omz; fi
  if test "$which_one" = "s"; then stock_zsh; fi
}

function aroace_arch_logo_pride () {
  yay -S blahaj --noconfirm --needed
  blahaj -c aroace hyprland/fastfetch/default_arch_logo > $HOME/.config/colton-dfiles/fastfetch_logo
}

function arch_logo_other_pride () {
  yay -S blahaj --noconfirm --needed
  blahaj --flags
  echo "which one do you want? (if you type an invalid config, I will NOT fix it, and DO NOT USE A CAPITAL LETTER WHEN TYPING IT!!)"
  read then_which_one_fucker
  blahaj -c "$then_which_one_fucker" hyprland/fastfetch/default_arch_logo > $HOME/.config/colton-dfiles/fastfetch_logo
}

function arch_logo_normal () {
  cp hyprland/fastfetch/default_arch_logo $HOME/.config/colton-dfiles/fastfetch_logo -fv
}

function blahaj_aroace_pride () {
  yay -S blahaj --noconfirm --needed
  blahaj -c aroace -s > $HOME/.config/colton-dfiles/fastfetch_logo
}

function blahaj_other_pride () {
  yay -S blahaj --noconfirm --needed
  blahaj --flags
  echo "which one do you want? (if you type an invalid config, I will NOT fix it, and DO NOT USE A CAPITAL LETTER WHEN TYPING IT!!)"
  read then_which_one_fucker
  blahaj -c "$then_which_one_fucker" -s > $HOME/.config/colton-dfiles/fastfetch_logo
}

function prompt_fastfetch () {
  set +x
  echo -e "which do you want for your fastfetch logo?\n * [a]roace arch logo (my current)\n * a [d]iffrent pride flag\n * [r]egular arch logo\n * Aroace [b]lahaj flag\n * [o]ther blahaj pride flag"

  read -n 1 which_flag_do_i_fucking_use

  set -x
  if test "$which_flag_do_i_fucking_use" = "a"; then aroace_arch_logo_pride; fi
  if test "$which_flag_do_i_fucking_use" = "d"; then arch_logo_other_pride; fi
  if test "$which_flag_do_i_fucking_use" = "r"; then arch_logo_normal; fi
  if test "$which_flag_do_i_fucking_use" = "b"; then blahaj_aroace_pride; fi
  if test "$which_flag_do_i_fucking_use" = "o"; then blahaj_other_pride; fi
  cp hyprland/fastfetch/config.jsonc $HOME/.config/fastfetch -fv
}

install_base_pkg
prompt_apps
copy_hyprland
gen_oomox_theme
change_shell
prompt_fastfetch

sudo -K

set +x
echo "Press any key to quit..."
read -n 1
