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

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

set -o vi
export EDITOR="vimx"
menu='fzy -l 30'
HISTFILESIZE=10000

alias handle_res='test -d "$selected_res" && cd "$selected_res" ; \
    test -f "$selected_res" && cd $(dirname "$selected_res") && $EDITOR $(basename "$selected_res")'

fd() {
    selected_res=$(find -name "*$1*" | $menu)
    test -z "$selected_res" && return
    $EDITOR "$selected_res"
    fd "$1"
}
gr() {
    selected_res=$(grep -l -r "$1" | $menu)
    test -z "$selected_res" && return
    $EDITOR +/"$1" "$selected_res"
    gr "$1"
}
f() {
    clear ; echo $PWD
    selected_res=$(ls -1 -a -F --indicator-style=none | sed '1 d' | $menu)
    test -z "$selected_res" && clear && return
    handle_res
    f
}
gm() { git commit -a -m "$1" && git push; }
cl() { readlink -f "$1" | xclip -sel clip; }

alias ba='echo $PWD >> "$XDG_DATA_HOME"/marks ; sort "$XDG_DATA_HOME"/marks | uniq > "$XDG_DATA_HOME"/marks.tmp && mv "$XDG_DATA_HOME"/marks.tmp "$XDG_DATA_HOME"/marks'
alias bj='selected=$(cat "$XDG_DATA_HOME"/marks | $menu) && cd "$selected"'
alias be='$EDITOR "$XDG_DATA_HOME"/marks'
alias ce='$EDITOR "$HOME"/.bashrc ; source "$HOME"/.bashrc'
alias ve='$EDITOR ~/.vimrc'
alias c='cd'
alias v='$EDITOR'
alias l='ls -A --color=auto -1 -p'
alias ga='git add --all'
alias gu='git pull'
alias gb="git branch"
alias gc="git checkout \$(git branch | $menu)"
alias up="sudo dnf5 upgrade --refresh -y"
alias te="tmux attach || tmux new -s yo"
alias dnf="dnf5"

