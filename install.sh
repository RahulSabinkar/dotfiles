#!/bin/bash
set -e

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Parse arguments
AUTO_YES=false
AUTO_NO=false

while getopts "yn" opt; do
  case $opt in
    y) AUTO_YES=true ;;
    n) AUTO_NO=true ;;
    *) echo "Usage: $0 [-y] [-n]" >&2; exit 1 ;;
  esac
done

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

# Function to handle prompts
confirm() {
    local prompt="$1"
    if [ "$AUTO_YES" = true ]; then
        return 0
    elif [ "$AUTO_NO" = true ]; then
        return 1
    else
        read -p "$prompt [Y/n] " -n 1 -r
        echo
        [[ $REPLY =~ ^[Yy]$ ]]
    fi
}

if confirm "Install main programs?"; then
    bash scripts/.scripts/setup/install_main.sh
else
    if confirm "Install minimal setup (git, stow, neovim, zsh, fzf, ripgrep, starship) instead?"; then
        sudo pacman -S --noconfirm --needed git stow neovim zsh fzf ripgrep starship
    fi
fi

if confirm "Install AUR programs?"; then
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

echo "6. Final Configuration..."

if confirm "Run final system configuration (npm, nvim plugins, fonts, cron)?"; then

    # Pass the flags to the sub-script

    if [ "$AUTO_YES" = true ]; then

        bash scripts/.scripts/setup/configure_system.sh -y

    elif [ "$AUTO_NO" = true ]; then

        bash scripts/.scripts/setup/configure_system.sh -n

    else

        bash scripts/.scripts/setup/configure_system.sh

    fi

fi



# Change shell to zsh

if [ "$SHELL" != "/bin/zsh" ]; then

    echo "Changing shell to zsh..."

    chsh -s /bin/zsh

fi



echo "Done! Please restart your shell."