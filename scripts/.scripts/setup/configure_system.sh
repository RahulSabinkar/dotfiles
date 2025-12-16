#!/bin/bash
set -e

# Parse arguments
AUTO_YES=false
AUTO_NO=false

while getopts "yn" opt;
do
  case $opt in
    y) AUTO_YES=true ;; 
    n) AUTO_NO=true ;; 
    *) echo "Usage: $0 [-y] [-n]" >&2; exit 1 ;; 
  esac
done

echo "Configuring system..."

# NPM Config
if command -v npm &> /dev/null; then
    echo "Setting npm prefix..."
    mkdir -p "$HOME/.npm-global"
    npm config set prefix "$HOME/.npm-global"
fi

# NPM Global Packages
if command -v npm &> /dev/null && [ -f "$HOME/dotfiles/programs/documents/npm_programs" ]; then
    if [ "$AUTO_NO" = true ]; then
        echo "Skipping NPM global packages (auto-no)."
    elif [ "$AUTO_YES" = true ]; then
        echo "Installing NPM global packages..."
        npm install -g $(grep -vE "^\s*#|^\s*$" "$HOME/dotfiles/programs/documents/npm_programs" | tr '\n' ' ')
    else
        read -p "Install global NPM packages? [Y/n] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "Installing NPM global packages..."
            npm install -g $(grep -vE "^\s*#|^\s*$" "$HOME/dotfiles/programs/documents/npm_programs" | tr '\n' ' ')
        fi
    fi
fi

# Vim-Plug
if [ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" ]; then
    echo "Installing Vim-Plug..."
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

# Install Vim Plugins
if command -v nvim &> /dev/null; then
    echo "Installing Neovim plugins..."
    nvim --headless +PlugInstall +qall || echo "Plugin installation had issues (non-critical)"
fi

# Fonts
echo "Refreshing font cache..."
fc-cache -fv || true

# Services
if command -v systemctl &> /dev/null; then
    echo "Enabling cronie..."
    sudo systemctl enable --now cronie || true
fi

echo "Configuration complete."