#!/bin/bash
set -e

# Install mise first if not present
if ! command -v mise &> /dev/null; then
  echo "Installing mise..."
  curl https://mise.run | sh >/dev/null 2>&1
  export PATH="$HOME/.local/bin:$PATH"
  # Reload shell to ensure mise is available
  hash -r
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
      "$HOME/.local/bin/mise" use --global go@latest
      ;;
    Python)
      "$HOME/.local/bin/mise" use --global python@latest
      ;;
    esac
  done
fi
