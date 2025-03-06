export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

set -o vi
export EDITOR="vimx"

alias handle_res='test -d "$selected_res" && cd "$selected_res" ; \
    test -f "$selected_res" && cd $(dirname "$selected_res") && vimx $(basename "$selected_res")'
alias copy_or_move_helper='selected_res=$(fd . "$HOME" | fzy -l 50) && \
    dest_dir=$(fd --type d . "$HOME" | fzy -l 50) && \
    test -z "$dest_dir" && dest_dir="./"'
alias cf='copy_or_move_helper ; \
    test -d "$selected_res" && cp -r "$selected_res" "$dest_dir" ; \
    test -f "$selected_res" && cp "$selected_res" "$dest_dir"'

ro() {
    selected_res=$(rg -l -g "!tags" "$1" | fzy -l 50)
    test -z "$selected_res" && return
    vimx +/"$1" "$selected_res" 
    lo "$1"
}
f() {
    clear ; echo $PWD
    selected_res=$(ls -1 -a | sed '1 d' | fzy -l 50)
    test -z "$selected_res" && return
    handle_res
    f
}
t() {
    level="${2:-99}"
    dir="${1:-.}"
    tree -C -I "__pycache__" -L"$level" "$dir" | less -R; 
}
fp() { ls | fzy | xargs -I{} "$1" {}; }
gm() { git commit -a -m "$1" && git push; }
rp() { rg -l -g "!tags" "$1" | xargs less +/"$1"; }
cl() { readlink -f "$1" | xclip -sel clip; }

alias mf='copy_or_move_helper ; mv "$selected_res" "$dest_dir"'
alias o='selected_res=$(fd . "$PWD" | fzy -l 50) ; handle_res'
alias ba='echo $PWD >> "$XDG_DATA_HOME"/marks ; sort "$XDG_DATA_HOME"/marks | uniq > "$XDG_DATA_HOME"/marks.tmp && mv "$XDG_DATA_HOME"/marks.tmp "$XDG_DATA_HOME"/marks'
alias bj='selected=$(cat "$XDG_DATA_HOME"/marks | fzy -l 50) && cd "$selected"'
alias be='vimx "$XDG_DATA_HOME"/marks'
alias ce='vimx "$HOME"/.bashrc ; source "$HOME"/.bashrc'
alias p='fd --type f -d 1 | xargs less'
alias c='cd'
alias v='vimx'
alias l='ls -A --color=auto -1 -p'
alias h='eval $(history 0 | fzy | awk "{\$1=\"\"; print \$0}" | xargs)'
alias ga='git add --all'
alias gu='git pull'
alias gb="git branch"
alias gc="git checkout \$(git branch | fzy -l 30)"
alias up="sudo xbps-install -Su"
alias pys='source ~/.local/pip/venvs/env1/bin/activate'

