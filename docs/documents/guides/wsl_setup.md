This is the **Arch WSL Survival Guide (2025 Edition)**.

This document chronicles every major hurdle we faced setting up a fresh Arch Linux instance on WSL 2, the specific errors encountered, and the final, working solutions we implemented.

Future Me, Your welcome!

---

### 1. Dotfiles & GNU Stow

**The Problem:** `stow` tries to symlink entire folders (like `.config`) if the target folder doesn't exist, linking the directory itself rather than the files inside. This pollutes the repo.

**The Fix:** Pre-create the folder structure before stowing. We made a script `setup_dirs.sh` located in `scripts/setup`. Use it.

### 2. Core Packages (The "Missing Tools" Error)

**The Problem:** Fresh Arch WSL is barebones. Missing `which`, `make`, `gcc`, `wget`, `unzip`, etc.

**The Solution:** Use the automated installer.

```bash
./install.sh
```

This script handles system updates, installing `base-devel`, essential tools, and gives you the option to install a full suite of programs or a minimal set (Git, Stow, Neovim, Zsh, FZF, Ripgrep, Starship).

### 3. Neovim & Clipboard (The "Interop" Bug)

**The Problem:** Neovim threw "Exec format error" when trying to access `cmd.exe` or `win32yank.exe`. Copy/Paste between Windows and Linux was broken.

**The Root Cause:** WSL Interop was disabled, preventing Linux from running Windows binaries.

**The Fix (Part A: Enable Interop):**

1. Edit `/etc/wsl.conf`:

```ini
[interop]
enabled=true
appendWindowsPath=true
```

2. **Restart WSL:** `wsl --shutdown` (in PowerShell).

**The Fix (Part B: Configure Neovim):**

1. Install `win32yank` (via Winget in Windows).
2. Add this to `init.vim` (Order matters! Define `g:clipboard` _before_ setting it):

```vim
let g:clipboard = {
  \   'name': 'win32yank-wsl',
  \   'copy': {
  \      '+': 'win32yank.exe -i --crlf',
  \      '*': 'win32yank.exe -i --crlf',
  \    },
  \   'paste': {
  \      '+': 'win32yank.exe -o --lf',
  \      '*': 'win32yank.exe -o --lf',
  \   },
  \   'cache_enabled': 0,
  \ }
set clipboard+=unnamedplus
```

### 4. Zsh & Visuals

**The Problem:** Terminal showing weird squares instead of icons, missing syntax highlighting.

- **The Icons:** Install **JetBrains Mono Nerd Font** on **Windows**, then set it in **Windows Terminal Settings -> Profiles -> Arch -> Appearance**.
- **The Setup:** The `install.sh` script automatically installs Zsh, Zsh plugins (autosuggestions, syntax highlighting), and changes your default shell to Zsh.

_(Note: If using `fast-syntax-highlighting`, install via AUR/yay)._

### 5. VS Code & AI Agents (OpenCode)

**The Problem:** Permission errors with `npm -g`, slow file transfer from Windows, need for Google Pro AI in terminal.

- **The Golden Rule:** Always clone repos inside `~` (Linux), not `/mnt/c/` (Windows).
- **The Setup:** The `install.sh` script (via `configure_system.sh`) automatically handles:
    - Setting NPM global prefix to `~/.npm-global` to avoid permission issues.
    - Installing `opencode-ai` and `@google/generative-ai` globally.

- **OpenCode Initialization:**

```bash
opencode
/connect  # Select Google Gemini, paste API Key from AI Studio
/init     # Run inside your repo to generate AGENTS.md
```

### 6. Git & SSH (Bitbucket/Github)

**The Problem:** Cannot push code, password prompts, HTTPS fails.

**The Solution:** Use SSH keys.

1. **Generate Key (Ed25519):**

```bash
ssh-keygen -t ed25519 -C "Arch WSL"
```

2. **Copy to Windows Clipboard:**

```bash
cat ~/.ssh/id_ed25519.pub | win32yank.exe -i --crlf
```

3. **Update Remote:**

```bash
git remote set-url origin git@bitbucket.org:User/Repo.git
```

### 7. The Network Boss Fight (JioFiber Slow Upload)

**The Problem:** `git push` crawling at 50kbps.

**The Cause:** JioFiber router + Hyper-V Virtual Switch packet fragmentation (Large Send Offload bug).

**The Fix (Mirrored Networking):**

1. Create a file in Windows: `C:\Users\YourUser\.wslconfig`.
2. Paste this content:

```ini
[wsl2]
networkingMode=mirrored
dnsTunneling=true
```

3. Run `wsl --shutdown`.

**Result:** Internet speed inside WSL matches Windows native speed. No hacky MTU commands needed.