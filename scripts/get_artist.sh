#!/usr/bin/env bash

full_artist="$(playerctl --player=ncspot metadata -f "{{ artist }}")"
artist=$(printf "%s" "$full_artist" | cut -d"," -f1)

if [[ $(playerctl --player=ncspot metadata -f "{{status}}") =~ Playing ]]; then
    cmd=$(playerctl --player=ncspot metadata -f "$artist")
fi

printf "%s" "$cmd"
