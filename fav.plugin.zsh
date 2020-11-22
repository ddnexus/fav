#!/usr/bin/env zsh

# Copyright (c) 2020 Domizio Demichelis - dd.nexus@gmail.com - https://github/com/ddnexus

_fav_version="0.2.0"
_fav_root=$(readlink -f $0 | xargs dirname)
_fav_functions=$(ls -p "$_fav_root/functions" | grep -v /)
fpath+=($_fav_root/functions)
hash -df

[[ -f ${FAV_FILE:=$HOME/.fav} ]] && source "$FAV_FILE" || { mkdir -p "$(dirname "$FAV_FILE")" && touch "$FAV_FILE" }

fav() {
    local fav_cmd="$1"
    autoload -Uz ${=_fav_functions} && _fav-init
    if ! type "_fav-cli-$fav_cmd" > /dev/null; then
        echo "[ERROR] Unknown fav command '$fav_cmd'!"
        echo
        _fav-cli-help
        return 1
    fi
    shift 1
    _fav-cli-$fav_cmd $@
}

fav-widget() {
    autoload -Uz ${=_fav_functions} && _fav-init
    local accept=$(should-accept-line)
    LBUFFER="${LBUFFER}$( _fav-widget )"
    local ret=$?
    zle redisplay
    typeset -f zle-line-init > /dev/null && zle zle-line-init
    [[ $ret -eq 0 && -n "$BUFFER" && -n "$accept" ]] && zle .accept-line
    return $ret
}

zle -N fav-widget
bindkey ${FAV_WIDGET_KEY:='^[v'} fav-widget
