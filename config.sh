#!/bin/bash

# NixlessNarwhal Configuration
# This file contains user-configurable variables used throughout the installation process.
# Modify these values to customize the installation for different users or directory structures.

# User configuration
USER_NAME="${USER_NAME:-cle126}"

# Home directory configuration
OLD_HOME_BASE="${OLD_HOME_BASE:-/home}"
NEW_HOME_BASE="${NEW_HOME_BASE:-/bc}"

# Derived paths (do not modify these directly)
# shellcheck disable=SC2034
OLD_HOME="${OLD_HOME_BASE}/${USER_NAME}"
# shellcheck disable=SC2034
NEW_HOME="${NEW_HOME_BASE}/${USER_NAME}"

# Installation directory
INSTALL_DIR="${INSTALL_DIR:-~/.local/share/NixlessNarwhal}"

