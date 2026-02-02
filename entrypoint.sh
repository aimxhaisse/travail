#!/bin/env zsh

if [ -n "$TRAVAIL_IS_BASE" ]; then
    echo "\033[1;33mWarning:\033[0m Entering 'base' directory, not a feature"
fi

if [ -f /workspace/.tool-versions ]; then
    $HOME/.local/bin/mise install
fi

exec $@
