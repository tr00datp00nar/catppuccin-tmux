#!/usr/bin/env bash

status="$(playerctl --player=ncspot metadata -f "{{status}}")"
full_artist="$(playerctl --player=ncspot metadata -f "{{ artist }}")"
artist=$(printf "%s" "$full_artist" | cut -d"," -f1)

if [[ "$status" =~ Playing ]]; then
  echo "$artist"
fi
