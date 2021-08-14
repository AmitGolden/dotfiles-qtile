# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.tar.xz)    tar xJf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)               # Include hidden files.

alias rm='rm -I'
alias mv='mv -i'
alias cp='cp -i'
alias ls='exa --icons --color=auto'
alias ll='ls -alhF'
alias lt='ls -thF'
alias grep='grep --color=auto'
alias cat='bat'
alias nvim='~/.config/qtile/misc/nvim.sh'
alias vim='nvim'
alias sudo='sudo '
# alias update='sudo pacman -Sy && sudo powerpill -Su && paru -Su'
alias update='paru -Syu'
alias checkupdates='checkupdates && paru -Qua'
alias removeOrphans='pacman -Qtdq | sudo pacman -Rns -'
alias teamviewer='sudo teamviewer --daemon start && teamviewer && sudo teamviewer --daemon stop'
alias xclip="xclip -selection c"
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias j="z"

alias ugit='~/.local/bin/ugit'
alias sub='~/.local/bin/OpenSubtitlesDownload.py'

function confup {
	config commit -m "update" && config push
}

function aliasexp {
  if [[ $ZSH_VERSION ]]; then
    # shellcheck disable=2154  # aliases referenced but not assigned
    [ ${aliases[$1]+x} ] && printf '%s\n' "${aliases[$1]}" && return
  else  # bash
    [ "${BASH_ALIASES[$1]+x}" ] && printf '%s\n' "${BASH_ALIASES[$1]}" && return
  fi
  false  # Error: alias not defined
}

function gitrelease {
	MASTER=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
	git push && git checkout $MASTER && git merge develop && git push && git checkout develop
}

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
	--color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229
	--color info:150,prompt:110,spinner:150,pointer:167,marker:174
	--reverse"

precmd () {print -Pn "\033]0;${PWD}\007"}


bindkey -v
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

source ~/.config/zsh/autopair.zsh                                 
autopair-init

function zvm_config {
	ZVM_KEYTIMEOUT=0.2
}

bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word

local WORDCHARS='*?_[]~=&;!#$%^(){}<>'


HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
KEYTIMEOUT=5

export EDITOR=nvim
export VISUAL=nvim
export QT_QPA_PLATFORMTHEME=qt5ct #gtk2
# export QT_STYLE_OVERRIDE=kvantum
export SHELL=zsh
export BAT_THEME=base16
# export TERM=kitty
export GDK_CORE_DEVICE_EVENTS=1

export BW_SESSION="ifIGi83yNlBdU6T9YH7TES/YIXIoYeu1NH9pBJ7WHXh8jZ/Ggud3AWxtsVAAe9XkTmS+2AsoAQ2p/6tCGS7m/g=="

export PATH=/home/amitgold/.local/bin:$PATH


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
zvm_after_init_commands+=('source /usr/share/fzf/completion.zsh && source /usr/share/fzf/key-bindings.zsh')
eval "$(zoxide init zsh)"
source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.zsh 2>/dev/null
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
