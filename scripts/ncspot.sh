#!/usr/bin/env bash

cmd=""

# Loop through all players and check if any is Playing
while read -r player; do
  status=$(playerctl -p "$player" status 2>/dev/null)
  if [[ "$status" == Playing ]]; then
    cmd=$(playerctl -p "$player" metadata --format '{{artist}} - {{title}}')
    break
  fi
done < <(playerctl -l 2>/dev/null)

# Print the output (or empty string if none playing)
printf "%s\n" "$cmd"
