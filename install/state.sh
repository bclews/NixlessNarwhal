#!/bin/bash

# NixlessNarwhal Installation State Management
# This file provides functions to track installation state and avoid re-installing components

# State file location
STATE_FILE="$HOME/.local/share/NixlessNarwhal/installed.state"

# Ensure state directory exists
mkdir -p "$(dirname "$STATE_FILE")"

# Create state file if it doesn't exist
if [ ! -f "$STATE_FILE" ]; then
    touch "$STATE_FILE"
fi

# Function to check if a component is already installed
is_installed() {
    local component="$1"
    grep -q "^${component}=true$" "$STATE_FILE" 2>/dev/null
}

# Function to mark a component as installed
mark_installed() {
    local component="$1"
    if ! is_installed "$component"; then
        echo "${component}=true" >> "$STATE_FILE"
    fi
}

# Function to mark a component as not installed
mark_not_installed() {
    local component="$1"
    sed -i "/^${component}=true$/d" "$STATE_FILE" 2>/dev/null || true
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if a package is installed via apt
apt_package_installed() {
    local package="$1"
    dpkg -l "$package" 2>/dev/null | grep -q "^ii"
}

# Function to check if user is in a group
user_in_group() {
    local group="$1"
    groups "$USER" | grep -q "\b$group\b"
}

# Function to skip installation if already done
skip_if_installed() {
    local component="$1"
    local description="$2"
    
    if is_installed "$component"; then
        echo "$description already installed, skipping..."
        return 0  # Skip installation
    else
        return 1  # Proceed with installation
    fi
}

# Function to run installation with state tracking
install_with_state() {
    local component="$1"
    local description="$2"
    local install_function="$3"
    
    if skip_if_installed "$component" "$description"; then
        return 0
    fi
    
    echo "Installing $description..."
    if $install_function; then
        mark_installed "$component"
        echo "$description installed successfully."
    else
        echo "Failed to install $description."
        return 1
    fi
}

# Function to show installation state
show_state() {
    echo "NixlessNarwhal Installation State:"
    echo "=================================="
    if [ -s "$STATE_FILE" ]; then
        while IFS='=' read -r component status; do
            if [ "$status" = "true" ]; then
                echo "✓ $component"
            fi
        done < "$STATE_FILE"
    else
        echo "No components installed yet."
    fi
}

# Function to reset installation state
reset_state() {
    if [ -f "$STATE_FILE" ]; then
        rm "$STATE_FILE"
        touch "$STATE_FILE"
        echo "Installation state reset."
    fi
}