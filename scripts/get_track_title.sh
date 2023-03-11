#!/usr/bin/env bash

full_title="$(playerctl --player=ncspot metadata -f "{{ title }}")"

# BUG:
# Fails when a song title includes hyphenated words instead of hyphens for separation of
#           [title - extra_info]
# Need to handle cases such as "Semi-Charmed Life" where the hyphen is not
# actually a delimeter. We are only interested in hyphens such as "Assassins - Remix"
# Would like to use a regex such as "/( - )|( \(\S)/" if possible.
title=$(printf "%s" "$full_title" | cut -d"(" -f1)

if [[ $(playerctl --player=ncspot metadata -f "{{status}}") =~ Playing ]]; then
    cmd=$(playerctl --player=ncspot metadata -f "$title")
fi

printf "%s" "$cmd"
