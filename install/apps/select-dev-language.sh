#!/bin/bash
set -e

# Load state management functions if not already loaded
if ! command -v command_exists >/dev/null 2>&1; then
    # shellcheck source=../state.sh
    source ~/.local/share/NixlessNarwhal/install/state.sh
fi

# Check if mise is available (should be installed via apt by mise.sh)
if ! command_exists mise; then
    echo "Error: mise is not installed. This should have been installed by mise.sh"
    exit 1
fi

# Determine mise path (prefer system install over local)
if command -v /usr/bin/mise >/dev/null 2>&1; then
    MISE_PATH="/usr/bin/mise"
elif command -v "$HOME/.local/bin/mise" >/dev/null 2>&1; then
    MISE_PATH="$HOME/.local/bin/mise"
else
    MISE_PATH="mise"  # Use PATH
fi

# Install default programming languages
if [[ -v FIRST_RUN_LANGUAGES ]]; then
  languages=$FIRST_RUN_LANGUAGES
else
  AVAILABLE_LANGUAGES=("Go" "Python")
  languages=$(gum choose "${AVAILABLE_LANGUAGES[@]}" --no-limit --height 10 --header "Select programming languages")
fi

if [[ -n "$languages" ]]; then
  for language in $languages; do
    case $language in
    Go)
      "$MISE_PATH" use --global go@latest
      ;;
    Python)
      "$MISE_PATH" use --global python@latest
      ;;
    esac
  done
fi
