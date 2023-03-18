#!/usr/bin/env bash

full_artist="$(playerctl --player=ncspot metadata -f "{{ artist }}")"
artist=$(printf "%s" "$full_artist" | cut -d"," -f1)

full_title="$(playerctl --player=ncspot metadata -f "{{ title }}")"

# BUG:
# Fails when a song title includes hyphenated words instead of hyphens for separation of
#           [title - extra_info]
# Need to handle cases such as "Semi-Charmed Life" where the hyphen is not
# actually a delimeter. We are only interested in hyphens such as "Assassins - Remix"
# Would like to use a regex such as "/( - )|( \(\S)/" if possible.
title=$(printf "%s" "$full_title" | cut -d"-" -f1 | cut -d"(" -f1)

if [[ $(playerctl --player=ncspot metadata -f "{{status}}") =~ Playing ]]; then
    cmd=$(playerctl --player=ncspot metadata -f "$title | $icon_artist $artist")
elif [[ $(playerctl --player=ncspot metadata -f "{{status}}") =~ Paused ]]; then
    printf "%s" "$icon_pause "
else
    printf "%s" "$icon_none "
fi

printf "%s" "$cmd"
