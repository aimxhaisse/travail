#!/bin/bash
if [ -f /workspace/.tool-versions ]; then
    mise install
fi
exec "$@"
