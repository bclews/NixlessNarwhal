#!/bin/bash

# Test script for NixlessNarwhal installation improvements
# This script validates the state tracking and idempotency features

set -e

echo "Testing NixlessNarwhal Installation Improvements"
echo "=============================================="

# Load the state management functions
source ./install/state.sh

echo ""
echo "Testing state management functions..."

# Test basic state functions
echo "- Testing state file creation..."
mkdir -p ~/.local/share/NixlessNarwhal
touch ~/.local/share/NixlessNarwhal/installed.state

echo "- Testing mark_installed function..."
mark_installed "test_component"
if is_installed "test_component"; then
    echo "✓ mark_installed works correctly"
else
    echo "✗ mark_installed failed"
    exit 1
fi

echo "- Testing duplicate marking..."
mark_installed "test_component"  # Should not duplicate
if [ "$(grep -c "test_component=true" ~/.local/share/NixlessNarwhal/installed.state)" -eq 1 ]; then
    echo "✓ No duplicate entries created"
else
    echo "✗ Duplicate entries found"
    exit 1
fi

echo "- Testing mark_not_installed function..."
mark_not_installed "test_component"
if ! is_installed "test_component"; then
    echo "✓ mark_not_installed works correctly"
else
    echo "✗ mark_not_installed failed"
    exit 1
fi

echo ""
echo "Testing helper functions..."

# Test command_exists
if command_exists bash; then
    echo "✓ command_exists works for existing command (bash)"
else
    echo "✗ command_exists failed for bash"
    exit 1
fi

if ! command_exists nonexistent_command_12345; then
    echo "✓ command_exists works for non-existing command"
else
    echo "✗ command_exists incorrectly found non-existent command"
    exit 1
fi

# Test skip_if_installed
mark_installed "skip_test"
if skip_if_installed "skip_test" "Skip Test Component"; then
    echo "✓ skip_if_installed correctly skips installed component"
else
    echo "✗ skip_if_installed failed to skip installed component"
    exit 1
fi

if ! skip_if_installed "not_installed_test" "Not Installed Test"; then
    echo "✓ skip_if_installed correctly allows non-installed component"
else
    echo "✗ skip_if_installed incorrectly skipped non-installed component"
    exit 1
fi

echo ""
echo "Testing state display..."
show_state

echo ""
echo "Cleaning up test state..."
reset_state

echo ""
echo "✓ All state management tests passed!"
echo "✓ Installation system ready for improved reliability"

echo ""
echo "To test the full installation with state tracking, run:"
echo "  source ~/.local/share/NixlessNarwhal/install.sh"
echo ""
echo "The system will now:"
echo "- Skip already installed components"
echo "- Track installation state"
echo "- Show installation summary"
echo "- Allow safe re-runs"