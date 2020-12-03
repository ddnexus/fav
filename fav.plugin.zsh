#!/usr/bin/env zsh

# Copyright (c) 2020 Domizio Demichelis - dd.nexus@gmail.com - https://github/com/ddnexus

_fav_version="0.3.0"
_fav_root=$(readlink -f $0 | xargs dirname)
fpath+=($_fav_root/functions)
autoload -Uz $(ls -p "$_fav_root/functions" | grep -v /)

${FAV_DIR_PREVIEW_CMD:=$( _fav-available-cmd 'exa -lbg --color=always' 'ls -l --color' ) }
${FAV_FILE_PREVIEW_CMD:=$( _fav-available-cmd 'bat --pager=always --style=numbers --color=always' less more ) }
export FAV_DIR_PREVIEW_CMD FAV_FILE_PREVIEW_CMD
${FAV_FZF_OPTS:='--height=50% --inline-info --exact --preview-window=noborder --reverse'}
${FAV_ORDER:=-time}
${FAV_ENABLE_ICONS:=false}
${FAV_DIR_ICON:=$($FAV_ENABLE_ICONS && echo ' ' || echo 'D')}        #  
${FAV_FILE_ICON:=$($FAV_ENABLE_ICONS && echo ' ' || echo 'F')}       #  
${FAV_UNKNOWN_ICON:=$($FAV_ENABLE_ICONS && echo '' || echo '?')}

zle -N fav-widget
bindkey ${FAV_WIDGET_KEY:='^[v'} fav-widget

hash -df

[[ -f ${FAV_FILE:=$HOME/.fav} ]] && source "$FAV_FILE" || { mkdir -p "$(dirname "$FAV_FILE")" && touch "$FAV_FILE" && _fav-welcome }
