#!/bin/bash

# ==============================================================================
# Dotfiles Directory Setup Script
# ==============================================================================
# Purpose: Pre-creates the directory structure in $HOME.
# Why:     This ensures GNU Stow symlinks individual files into these folders
#          rather than symlinking the entire folder itself (which causes
#          git tracking issues and pollution).
# ==============================================================================

echo "Creating config directory structure..."

# 1. Create .config subdirectories
#    (We create these so stow links the contents inside, not the folder itself)
mkdir -p ~/.config/{calcurse,dunst,lf,mpv,neofetch,newsboat,nvim,pcmanfm,ranger,redshift,sxiv,transmission-daemon,zathura,zsh}

# 2. Create local share directories
#    (Note: We deliberately DO NOT create 'emoji' here because it is a file, not a folder)
mkdir -p ~/.local/share/applications

# 3. Create binary and script directories
mkdir -p ~/.local/bin
mkdir -p ~/.scripts

# 4. Create Documents folder (targets for stow)
mkdir -p ~/documents

# 5. Create Zsh History folder
#    (Zsh often fails to save history if this folder doesn't exist)
mkdir -p ~/.cache/zsh

# 6. Create NPM Global folder
#    (Prevents needing sudo for npm install -g)
mkdir -p ~/.npm-global

echo "✅ Directory structure created."
echo "Run simulation of stow with: stow --verbose --simulate *"
echo "Then apply with: stow --verbose *"