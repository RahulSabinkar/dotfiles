#!/bin/bash

# Install main programs from the list
if [ -f "$HOME/dotfiles/programs/documents/mainprograms" ]; then
    echo "Installing main programs..."
    sudo pacman -S --noconfirm --needed - < <(grep -vE "^\s*#|^\s*$" "$HOME/dotfiles/programs/documents/mainprograms")
else
    echo "Main programs list not found!"
fi
