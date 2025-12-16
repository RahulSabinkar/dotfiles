#!/bin/bash

# Check if running on Arch Linux
if ! grep -q "Arch Linux" /etc/os-release; then
    echo "Skipping AUR programs (Not on Arch Linux)."
    exit 0
fi

# Install AUR programs from the list
if [ -f "$HOME/dotfiles/programs/documents/aurprograms" ]; then
    echo "Installing AUR programs..."
    yay -S --noconfirm --needed - < <(grep -vE "^\s*#|^\s*$" "$HOME/dotfiles/programs/documents/aurprograms")
else
    echo "AUR programs list not found!"
fi
