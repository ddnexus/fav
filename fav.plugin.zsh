#!/usr/bin/env zsh

FAV_KEY=${FAV_KEY:-'^[v'}
[[ -f ${FAV_FILE:=$HOME/.fav} ]] || mkdir -p "$(dirname "$FAV_FILE")" && touch "$FAV_FILE"
! (( ${+FAV_FZF_PREVIEW} )) && { (( $+commands[exa] )) && FAV_FZF_PREVIEW='--preview="exa -lbg --git --color=always {-1}"' || FAV_FZF_PREVIEW='--preview="ls -l {-1}"' }

fav+() {
    local name=${1:-$(basename $PWD)}
    name=$( sed -e 's/[^A-Za-z0-9._-]/_/g; s/^-/_/' <<< $name ) # handle invalid chars for hash name
    [[ -n $(hash -dm $name) && -d ~$name ]] && echo "[ERROR] Found valid duplicate: $name ->" ~$name "-- please, use a different name!" && return 1
    echo "hash -d $name=$PWD" >> "$FAV_FILE"
    fav::load
    echo "[ADDED]  $name  ->  $PWD"
}

fav-() { fav::ls | fav::fzf --query="$*" -1 --nth=1,2,4 | fav::rm }

fav?() { fav::ls | awk '{ if ($3 == "??") print }' | column -t }

fav?-() { fav? | fav::rm }

fav::load() { source "$FAV_FILE" }

fav::fzf() { grep --color=${FAV_COLORIZE_MISSING:-'always'} -E ".*  \?\?  .*|$" | eval "fzf $FAV_FZF_OPTS $FAV_FZF_PREVIEW --ansi -m $@" }

fav::ls() { sed 's/hash -d \([^=]*\)=/\1 -> /' "$FAV_FILE" | nl | awk '{ if (system("test -d " $4)) $3="??"; print }' | column -t }

fav::rm() { 
    awk -vfile="$FAV_FILE" '{ lines=lines$1"d;"; $1="[REMOVED]"; print } END { system("sed -i \"" lines "\"" FS file) }' |
        column -t | grep . && { hash -drf; fav::load } 
}

fav::widget() {
    local accept=$(should-accept-line)
    LBUFFER="${LBUFFER}$( fav::ls | fav::fzf --nth=2,4 | awk -vORS=" " '{ print "~"$2 }' )"
    local ret=$?
    zle redisplay
    typeset -f zle-line-init >/dev/null && zle zle-line-init
    [[ $ret -eq 0 && -n "$BUFFER" && -n "$accept" ]] && zle .accept-line
    return $ret
}

fav::load

zle -N fav::widget
bindkey $FAV_KEY fav::widget
