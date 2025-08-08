# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

NixlessNarwhal is a system setup tool for fresh Ubuntu 24.04+ installations on x86 architectures. It provides automated installation of development tools and applications without using Nix package manager. The tool is designed for headless Ubuntu systems and follows a modular installation approach.

## Architecture

The project follows a hierarchical shell script architecture:

- `boot.sh` - Entry point that displays ASCII art, clones the repository locally, and initiates installation
- `install.sh` - Main installation orchestrator that coordinates the setup process
- `config.sh` - Configuration file with user-customizable variables and paths
- `install/check-version.sh` - System compatibility validation (Ubuntu 24.04+, x86 architecture)
- `install/first-run-choices.sh` - Interactive language selection using gum
- `install/required/` - Essential system components that must be installed
- `install/apps/` - Optional applications that can be installed

### Installation Flow

1. **Configuration Loading**: Loads user settings from `config.sh`
2. **System Validation**: Checks OS compatibility and architecture requirements
3. **Interactive Choices**: Uses gum for language selection via `first-run-choices.sh`
4. **Home Directory Migration**: Moves user home from `/home/cle126` to `/bc/cle126` (if needed)
5. **Core Libraries**: Installs essential development tools via `libraries.sh`
6. **Zsh Setup**: Installs and configures zsh with Oh My Zsh
7. **Applications**: Installs all applications from `install/apps/` directory

### Key Components

**Configuration Files**:

- `config.sh` - Central configuration with user settings, home directory paths, and installation directory
- `install/first-run-choices.sh` - Interactive language selection using gum (Go, Python available)

**Required Components** (`install/required/`):

- `gum.sh` - Installs gum for interactive prompts and selections
- `move-home.sh` - Relocates user home directory with proper permission handling
- `libraries.sh` - Installs core development tools (build-essential, ripgrep, fd-find, etc.)
- `zsh.sh` - Installs and configures zsh with Oh My Zsh
- `git-ssh.sh`, `nix.sh` - Additional system setup (not currently active)

**Applications** (`install/apps/`):

- `docker.sh` - Docker with official repository setup and user group configuration
- `neovim.sh` - Neovim from GitHub releases
- `lazygit.sh` - Git TUI tool
- `lazydocker.sh` - Docker TUI tool
- `eza.sh` - Modern ls replacement
- `fastfetch.sh` - System information tool
- `fzf.sh` - Fuzzy finder
- `select-dev-language.sh` - Language-specific development tools

## Development Commands

This is a shell script-based project with no traditional build system. Key operations:

### Running the Installation

```bash
# Full installation from entry point
./boot.sh

# Resume/retry installation
source ~/.local/share/NixlessNarwhal/install.sh
```

### Testing Individual Components

```bash
# Test specific installation modules
source ~/.local/share/NixlessNarwhal/install/required/libraries.sh
source ~/.local/share/NixlessNarwhal/install/apps/docker.sh
```

### Validation

```bash
# Check system compatibility
source ~/.local/share/NixlessNarwhal/install/check-version.sh
```

## Error Handling

The project uses bash `set -e` for fail-fast behavior and includes error traps that provide retry instructions. The installation process is designed to be resumable if interrupted.

## Security Considerations

- Scripts download and execute code from external sources (GitHub, Docker, nvm)
- User is added to docker group for privileged container access  
- Home directory relocation modifies system files (/etc/passwd)
- All operations require sudo privileges for system modifications

