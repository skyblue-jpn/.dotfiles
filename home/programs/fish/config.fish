#!/bin/fish

if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting

end

starship init fish | source

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

/usr/bin/mise activate fish --shims | source

## Run fastfetch if session is interactive
if status --is-interactive && type -q fastfetch
   fastfetch
end

abbr ei "eza --icons --git"
abbr ea "eza -a --icons --git"
abbr ee "eza -aahl --icons --git"
abbr et "eza -T -L 3 -a -I 'node_modules|.git|.cache' --icons"
abbr eta "eza -T -a -I 'node_modules|.git|.cache' --color=always --icons | less -r"
abbr ls ei
abbr la ea
abbr ll ee
abbr lt et
abbr lta eta
abbr l "clear && ls"
