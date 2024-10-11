feh --bg-fill --no-fehbg ~/.local/share/wallpapers/Shani.png &

picom --config ~/.config/picom/picom.conf &

command -v dex &>/dev/null && dex -a &

command -v udiskie &>/dev/null && udiskie &

pulseaudio --start
