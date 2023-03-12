<h3 align="center">
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/logos/exports/1544x1544_circle.png" width="100" alt="Logo"/><br/>
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/misc/transparent.png" height="30" width="0px"/>
	Catppuccin for <a href="https://github.com/tmux/tmux">Tmux</a>
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/misc/transparent.png" height="30" width="0px"/>
</h3>

<p align="center">
    <a href="https://github.com/catppuccin/tmux/stargazers"><img src="https://img.shields.io/github/stars/catppuccin/tmux?colorA=363a4f&colorB=b7bdf8&style=for-the-badge"></a>
    <a href="https://github.com/catppuccin/tmux/issues"><img src="https://img.shields.io/github/issues/catppuccin/tmux?colorA=363a4f&colorB=f5a97f&style=for-the-badge"></a>
    <a href="https://github.com/catppuccin/tmux/contributors"><img src="https://img.shields.io/github/contributors/catppuccin/tmux?colorA=363a4f&colorB=a6da95&style=for-the-badge"></a>
</p>

<p align="center">
  <img src="./assets/preview.webp"/>
</p>

# Catppuccin-Tmux
This is a fork of the original Catppuccin theme for Tmux.

## Added Features
- Ncspot widget (Dependencies: ncspot, playerctl)
- Weather widget
- Time Widget

## Removed Features
- Window tabs

## Themes

- 🌻 [Latte](./catppuccin-latte.tmuxtheme)
- 🪴 [Frappé](./catppuccin-frappe.tmuxtheme)
- 🌺 [Macchiato](./catppuccin-macchiato.tmuxtheme)
- 🌿 [Mocha](./catppuccin-mocha.tmuxtheme)

## Usage

### TPM

1. Install [TPM](https://github.com/tmux-plugins/tpm)
2. Add the forked Catppuccin-Tmux plugin:

```bash
set -g @plugin 'tr00datp00nar/catppuccin-tmux'
# ...alongside
set -g @plugin 'tmux-plugins/tpm'
```

3. (Optional) Set your preferred flavour, it defaults to `"mocha"`:

```bash
set -g @catppuccin_flavour 'latte' # or frappe, macchiato, mocha
```

### Manual

1. Copy your desired theme's configuration contents into your Tmux config (usually stored at `~/.tmux.conf`)
2. Reload Tmux by either restarting the session or reloading it with `tmux source-file ~/.tmux.conf`

#### Configuration options

All flavours support certain levels of customization that match our [Catppuccin
Style Guide][style-guide]. To add these customizations, add any of the following
options to your Tmux configuration.

##### Widget Configuration Defaults

```sh
set -g @catppuccin_show_location false
set -g @catppuccin_show_fahrenheit false
set -g @catppuccin_fixed_location
set -g @catppuccin_show_time "on"
set -g @catppuccin_show_military "off"
set -g @catppuccin_show_day_month "off" # Set to "on" to show date as DAY/MONTH instead of MONTH/DAY
set -g @catppuccin_show_timezone false
set -g @catppuccin_ncspot_enabled "off"
```

###### Show location in weather widget

Set `@catppuccin_show_location true` to allow the theme to find your location with a call to https://ipinfo.io and append it to the forecast.
Set `@catppuccin_fixed_location [LOCATION]` to set a fixed location for the widget. Uses https://wttr.in

[style-guide]: https://github.com/catppuccin/catppuccin/blob/main/docs/style-guide.md

## Create a custom color scheme

While we are pretty sure you will enjoy our selection of color schemes, if you would like to customize your own setup, you can do so by adding a new `.tmuxtheme` file to the plugin folder (`/path/to/tmux/configuration/plugins/catppuccin-tmux/`) with your custom colors.

## 💝 Thanks to

- [Pocco81](https://github.com/catppuccin)
- [vinnyA3](https://github.com/vinnyA3)
- [rogeruiz](https://github.com/rogeruiz)

&nbsp;

<p align="center"><img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" /></p>
<p align="center">Copyright &copy; 2021-present <a href="https://github.com/catppuccin" target="_blank">Catppuccin Org</a>
<p align="center"><a href="https://github.com/catppuccin/catppuccin/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&logoColor=d9e0ee&colorA=363a4f&colorB=b7bdf8"/></a></p>
