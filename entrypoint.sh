#!/bin/env zsh

if [ -f /workspace/.tool-versions ]; then
    mise install
fi

exec $@
