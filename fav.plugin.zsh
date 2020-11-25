#!/usr/bin/env zsh

# Copyright (c) 2020 Domizio Demichelis - dd.nexus@gmail.com - https://github/com/ddnexus

_fav_version="0.2.0"
_fav_root=$(readlink -f $0 | xargs dirname)
fpath+=($_fav_root/functions)
autoload -Uz $(ls -p "$_fav_root/functions" | grep -v /)

[[ -f ${FAV_FILE:=$HOME/.fav} ]] && source "$FAV_FILE" || { mkdir -p "$(dirname "$FAV_FILE")" && touch "$FAV_FILE" }
FAV_DIR_PREVIEW_CMD=${FAV_DIR_PREVIEW_CMD:-$( _fav-available-cmd 'exa -lbg --git --color=always' 'ls -l' ) }
FAV_FILE_PREVIEW_CMD=${FAV_FILE_PREVIEW_CMD:-$( _fav-available-cmd 'bat --paging=always' less more ) }
export FAV_DIR_PREVIEW_CMD FAV_FILE_PREVIEW_CMD
FAV_ENABLE_ICONS=${FAV_ENABLE_ICONS:-false}
FAV_DIR_ICON=${FAV_DIR_ICON:-$($FAV_ENABLE_ICONS && echo ' ' || echo 'D')}         #     
FAV_FILE_ICON=${FAV_FILE_ICON:-$($FAV_ENABLE_ICONS && echo ' ' || echo 'F')}       #     
FAV_UNKNOWN_ICON=${FAV_UNKNOWN_ICON:-$($FAV_ENABLE_ICONS && echo '' || echo '?')}

zle -N fav-widget
bindkey ${FAV_WIDGET_KEY:='^[v'} fav-widget

hash -df
