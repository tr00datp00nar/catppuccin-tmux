#!/usr/bin/env bash

status="$(playerctl --player=ncspot metadata -f "{{ status }})"
full_title="$(playerctl --player=ncspot metadata -f "{{ title }}")"

# Trims track title from any opening parentheses.
title=$(printf "%s" "$full_title" | sed -re 's/\(.*\).*$//i')

if [[ $status =~ Playing ]]; then
    printf "%s "$title"
fi
