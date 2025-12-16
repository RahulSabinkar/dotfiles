#!/bin/bash
set -e

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "1. Updating system..."
sudo pacman -Syu --noconfirm --needed git base-devel stow

echo "2. Installing AUR Helper (yay)..."
if ! command -v yay &> /dev/null; then
    if grep -q "Arch Linux" /etc/os-release; then
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay && makepkg -si --noconfirm && cd "$DOTFILES_DIR"
    else
        echo "Not on Arch Linux, skipping yay installation."
    fi
else
    echo "yay is already installed."
fi

echo "3. Installing Packages..."
read -p "Install main programs? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    bash scripts/.scripts/setup/install_main.sh
else
    read -p "Install minimal setup (git, stow, neovim, zsh, fzf, ripgrep, starship) instead? [Y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo pacman -S --noconfirm --needed git stow neovim zsh fzf ripgrep starship
    fi
fi

read -p "Install AUR programs? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
   bash scripts/.scripts/setup/install_aur.sh
fi

echo "4. Setting up Directories..."
bash scripts/.scripts/setup/setup_dirs.sh

echo "5. Stowing Configurations..."
# Stow all top-level folders except specific ones
for folder in */; do
    folder_name=${folder%/}
    if [[ ! "$folder_name" =~ ^(programs|docs|scripts|.git)$ ]]; then
        stow -R "$folder_name"
    fi
done
# Stow specific folders
stow -R scripts programs docs

echo "Done! Please restart your shell."
