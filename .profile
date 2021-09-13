export EDITOR=~/.config/qtile/misc/nvim.sh
export VISUAL=~/.config/qtile/misc/nvim.sh
export QT_QPA_PLATFORMTHEME=qt5ct 
# export QT_STYLE_OVERRIDE=kvantum
export BAT_THEME=base16
export GDK_CORE_DEVICE_EVENTS=1

export BW_SESSION="ifIGi83yNlBdU6T9YH7TES/YIXIoYeu1NH9pBJ7WHXh8jZ/Ggud3AWxtsVAAe9XkTmS+2AsoAQ2p/6tCGS7m/g=="

export PATH=/home/amitgold/.local/bin:$PATH

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
	--color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229
	--color info:150,prompt:110,spinner:150,pointer:167,marker:174
	--preview "less ${(Q)realpath} {}"
	--reverse'

# Colorful man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# For terminal resizing in Qtile
unset LINES; unset COLUMNS;
