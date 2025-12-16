# Dotfiles - System Configuration

This directory contains the user's personal configuration files ("dotfiles") for a Linux environment, managed using GNU Stow. It is designed to be a portable and reproducible setup for tools like Zsh, Neovim, Ranger, and the DWM window manager.

## Project Overview

- **Type:** Configuration / Dotfiles
- **Operating System:** Linux (Arch Linux)
- **Management Tool:** [GNU Stow](https://www.gnu.org/software/stow/)
- **Window Manager:** DWM (Dynamic Window Manager)
- **Shell:** Zsh (with Starship prompt)

## Directory Structure & Logic

The repository is organized so that each top-level directory represents a package/program. Inside these directories, the file structure mirrors the target structure in the `$HOME` directory.

**Example:**

- **Source:** `nvim/.config/nvim/init.vim`
- **Target:** `~/.config/nvim/init.vim`

When `stow nvim` is run, it creates a symlink from the target to the source.

### Key Directories

- `bash/`, `zsh/`: Shell configurations.
- `scripts/`: Custom utility scripts located in `~/.local/bin` and `~/.scripts`.
- `nvim/`: Neovim configuration (`init.vim`).
- `xinitc/`: X11 startup script (`.xinitrc`), which launches DWM.
- `programs/`: Lists of installed packages for system restoration.

## Setup & Installation

To set up this configuration on a new machine:

1.  **Clone the Repository:**

    ```bash
    git clone <repository-url> ~/dotfiles
    cd ~/dotfiles
    ```

2.  **Prepare Directory Structure:**
    Run the setup script to create necessary parent directories. This prevents `stow` from symlinking entire folders (which causes git issues) and ensures it only symlinks the specific config files.

    ```bash
    ./scripts/.scripts/setup/setup_dirs.sh
    ```

3.  **Apply Configurations:**
    Use `stow` to create symlinks for all packages.
    ```bash
    stow --verbose *
    ```
    _Note: You may need to ignore specific files like `GEMINI.md` or `.git` if `stow` complains, or explicitly list packages: `stow zsh nvim scripts ...`_

## Common Tasks

### Adding a New Configuration

1.  Create a folder for the program: `mkdir <program_name>`
2.  Recreate the path relative to home: `mkdir -p <program_name>/.config/<program_name>`
3.  Move the config file in: `mv ~/.config/<program_name>/config <program_name>/.config/<program_name>/`
4.  Run stow: `stow <program_name>`

### Updating Changes

Since files are symlinked, editing the file in `~/.config/...` automatically updates the file in `~/dotfiles`. You just need to commit and push the changes from the `~/dotfiles` directory.

## Key Configurations

- **Startup:** `xinitc/.xinitrc` handles the X server startup, launching services like `dunst`, `picom`, and finally `dwm`.
- **Shell:** `zsh/.config/zsh/.zshrc` sets up the environment, aliases, and prompt.
- **Scripts:** `scripts/.scripts/` contains various custom utilities for system management, dmenu integration, and status bar modules.
