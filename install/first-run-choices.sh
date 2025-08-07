#!/bin/bash
set -e

AVAILABLE_LANGUAGES=("Go" "Python")
SELECTED_LANGUAGES="Python"
FIRST_RUN_LANGUAGES=$(gum choose "${AVAILABLE_LANGUAGES[@]}" --no-limit --selected "$SELECTED_LANGUAGES" --height 10 --header "Select programming languages")
export FIRST_RUN_LANGUAGES
