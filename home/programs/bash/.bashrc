#!/bin/bash

eval "$(starship init bash)"

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd" || exit
    fi
    rm -f -- "$tmp"
}

eval "$(/usr/bin/mise activate bash --shims)"
