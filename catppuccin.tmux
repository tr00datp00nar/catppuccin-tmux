#!/usr/bin/env bash
PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

get_tmux_option() {
  local option value default
  option="$1"
  default="$2"
  value="$(tmux show-option -gqv "$option")"

  if [ -n "$value" ]; then
    echo "$value"
  else
    echo "$default"
  fi
}

set() {
  local option=$1
  local value=$2
  tmux_commands+=(set-option -gq "$option" "$value" ";")
}

setw() {
  local option=$1
  local value=$2
  tmux_commands+=(set-window-option -gq "$option" "$value" ";")
}

main() {
  local theme
  theme="$(get_tmux_option "@catppuccin_flavour" "mocha")"

  # Aggregate all commands in one array
  local tmux_commands=()

  # NOTE: Pulling in the selected theme by the theme that's being set as local
  # variables.
  # shellcheck source=catppuccin-frappe.tmuxtheme
  source /dev/stdin <<<"$(sed -e "/^[^#].*=/s/^/local /" "${PLUGIN_DIR}/catppuccin-${theme}.tmuxtheme")"

  # status
  set status "on"
  set status-bg "${thm_bg}"
  set status-justify "centre"
  set status-left-length "100"
  set status-right-length "100"

  # messages
  set message-style "fg=${thm_cyan},bg=${thm_gray},align=centre"
  set message-command-style "fg=${thm_cyan},bg=${thm_gray},align=centre"

  # panes
  set pane-border-style "fg=${thm_gray}"
  set pane-active-border-style "fg=${thm_blue}"

  # windows
  setw window-status-activity-style "fg=${thm_fg},bg=${thm_bg},none"
  setw window-status-separator ""
  setw window-status-style "fg=${thm_fg},bg=${thm_bg},none"

  # --------=== Statusline

  # NOTE: Checking for the value of @catppuccin_window_tabs_enabled
  local wt_enabled
  wt_enabled="$(get_tmux_option "@catppuccin_window_tabs_enabled" "off")"
  readonly wt_enabled

  # NOTE: Checking for the value of @catppuccin_ncspot_enabled
  local ncspot_enabled
  ncspot_enabled="$(get_tmux_option "@catppuccin_ncspot_enabled" "off")"
  readonly ncspot_enabled

  # NOTE: Checking for the value of weather related vars
  local weather_enabled
  weather_enabled="$(get_tmux_option "@catppuccin_weather_enabled" "off")"
  readonly weather_enabled
  local show_fahrenheit
  show_fahrenheit="$(get_tmux_option "@catppuccin_show_fahrenheit" true)"
  readonly show_fahrenheit
  local show_location
  show_location="$(get_tmux_option "@catppuccin_show_location" false)"
  local fixed_location
  fixed_location="$(get_tmux_option "@catppuccin_fixed_location")"
  readonly fixed_location

  # Start weather script in the background
  if [[ $weather_enabled == "on" ]]; then
    ${PLUGIN_DIR}/scripts/sleep_weather.sh $show_fahrenheit $show_location $fixed_location &
  fi

  datafile=/tmp/.catppuccin-tmux-data

  # These variables are the defaults so that the setw and set calls are easier to parse.
  local show_directory
  readonly show_directory="#[fg=$thm_pink,bg=$thm_bg,nobold,nounderscore,noitalics]#[fg=$thm_bg,bg=$thm_pink,nobold,nounderscore,noitalics]  #[fg=$thm_bg,bg=$thm_pink] #{b:pane_current_path} #{?client_prefix,#[fg=$thm_red]"
  local show_window
  readonly show_window="#[fg=$thm_pink,bg=$thm_bg,nobold,nounderscore,noitalics]#[fg=$thm_bg,bg=$thm_pink,nobold,nounderscore,noitalics] #[fg=$thm_bg,bg=$thm_pink] #W #[fg=$thm_pink,bg=$thm_gray,nobold,nounderscore,noitalics]#{?client_prefix,#[fg=$thm_red]"
  local show_session
  readonly show_session="#[fg=$thm_green]}#[bg=$thm_gray]#{?client_prefix,#[bg=$thm_red],#[bg=$thm_green]}#[fg=$thm_bg] #[fg=$thm_bg,bg=$thm_green] #S #[fg=$thm_green,bg=$thm_gray,nobold,nounderscore,noitalics]"
  local show_directory_in_window_status
  readonly show_directory_in_window_status="#[fg=$thm_fg,bg=$thm_gray] #I #[fg=$thm_fg,bg=$thm_gray] #{b:pane_current_path} "
  local show_directory_in_window_status_current
  readonly show_directory_in_window_status_current="#[fg=$thm_orange,bg=$thm_bg,nobold,nounderscore,noitalics]#[fg=$thm_bg,bg=$thm_orange] #I #[fg=$thm_bg,bg=$thm_orange] #{b:pane_current_path} #[fg=$thm_orange,bg=$thm_bg,nobold,nounderscore,noitalics]"
  local show_window_in_window_status
  readonly show_window_in_window_status="#[fg=$thm_bg,bg=$thm_blue] #W #[fg=$thm_bg,bg=$thm_blue] #I#[fg=$thm_blue,bg=$thm_bg]#[fg=$thm_fg,bg=$thm_bg,nobold,nounderscore,noitalics] "
  local show_window_in_window_status_current
  readonly show_window_in_window_status_current="#[fg=$thm_bg,bg=$thm_orange] #W #[fg=$thm_bg,bg=$thm_orange] #I#[fg=$thm_orange,bg=$thm_bg]#[fg=$thm_fg,bg=$thm_bg,nobold,nounderscore,noitalics] "
  local show_ncspot_track_title
  readonly show_ncspot_track_title="#[fg=$thm_blue,bg=$thm_bg,nobold,nounderscore,noitalics] #[fg=$thm_bg,bg=$thm_blue,nobold,nounderscore,noitalics] #[fg=$thm_bg,bg=$thm_blue] #(${PLUGIN_DIR}/scripts/get_track_title.sh)"
  local show_ncspot_artist
  readonly show_ncspot_artist="#[fg=$thm_bg,bg=$thm_blue,nobold,nounderscore,noitalics] #[fg=$thm_bg=$thm_blue]#(${PLUGIN_DIR}/scripts/get_artist.sh) #[fg=$thm_blue,bg=$thm_bg,nobold,nounderscore,noitalics]"
  local show_weather
  readonly show_weather="#[fg=$thm_orange,bg=$thm_bg,nobold,nounderscore,noitalics]#[fg=thm_bg,bg=thm_orange]#(cat $datafile) #[fg=$thm_orange,bg=$thm_bg,nobold,nounderscore,noitalics]"

  # Right column 1 by default shows the current Session name.
  local left_column1=$show_session
  # Left column 2 by default shows the Window name.
  local left_column2=$show_window

  # Window status by default shows the current directory basename.
  local window_status_format=$show_directory_in_window_status
  local window_status_current_format=$show_directory_in_window_status_current

  # NOTE: With the @catppuccin_ncspot_enabled set to on, we're going to
  # update the right column1.
  if [[ "${ncspot_enabled}" == "on" ]]; then
    right_column1=$show_ncspot_track_title
    right_column2=$show_ncspot_artist
    fi

  # NOTE: With the @catppuccin_weather_enabled set to on, we're going to
  # update the right_column3
  if [[ "${weather_enabled}" == "on" ]]; then
    right_column3=$show_weather
  fi

  set status-left "${left_column1}${left_column2}"

  set status-right "${right_column1} ${right_column2} ${right_column3}"

  setw window-status-format "${window_status_format}"
  setw window-status-current-format "${window_status_current_format}"

  # --------=== Modes
  #
  setw clock-mode-colour "${thm_blue}"
  setw mode-style "fg=${thm_pink} bg=${thm_black4} bold"

  tmux "${tmux_commands[@]}"
}

main "$@"
