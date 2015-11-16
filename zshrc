zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' max-errors 10
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit && compinit

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=12000
#setopt appendhistory
setopt autocd correct extendedglob nomatch histignorealldups
setopt incappendhistory
unsetopt beep notify
bindkey -e

# default programs
export EDITOR=vim
export BROWSER=firefox

# Initialize colors.
autoload -U colors && colors

# dynamicly load addons
for file in $HOME/.dotfiles/zsh/*/zshrc.sh; do
    source $file
done

# prompt with current path on the right side
RPROMPT=' %(?.%(!.%/.%~).:()'

# left side
PROMPT="%{$fg[green]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%}\$(git_super_status) %# "

# directory stack
setopt autopushd

# make columns as small as possible
setopt listpacked

# sort order of 'ls -v'
setopt numericglobsort

# zstyle ':completion:*' menu select=1
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# enable arrow keys in combination with [ctrl]
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
# stop at dots
export WORDCHARS='.'

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

######################################
# ALIAS
######################################

alias ls='ls --color=always -F -v'
alias la='ls --color=always -a'
alias ll='ls --color=always -l'

alias hd='hexdump -C -v'

alias grep="grep --color=always --line-number"

export LESS='-r'

alias gdb="gdb -quiet"

alias make="make -j4"

alias df="df --human-readable"

alias apg='/usr/bin/apg -a1 -m16 -x16 -n1 -MNL /dev/urandom'
alias apg_short='/usr/bin/apg -a0 -m10 -x10 -n1 -MNL /dev/urandom'

alias objdump='objdump -Mintel -d'

alias gcc="gcc -g"

alias vim-git='vim `git status --porcelain | cut -d " " -f 3`'

# debian based
#alias UPDATE="sudo apt-get update && sudo apt-get dist-upgrade"

# arch
#alias UPDATE="sudo pacman -Syu"

## suffix-alias
# suffix: editor
alias -s txt=vim tex=gvim cc=vim cpp=vim h=vim hpp=vim pl=vim
# suffix: wireshark
alias -s cap=wireshark pcap=wireshark pcapng=wireshark
alias -s pdf=evince


# ++++++++++++++++++++++++++++++++++++
# Ruby
# ++++++++++++++++++++++++++++++++++++

# Ruby gem
export PATH=$PATH:$HOME/.gem/ruby/2.0.0/bin

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# man 5 terminfo; man console_codes
export LESS_TERMCAP_mb="${fg[cyan]}"        # turn on blinking
export LESS_TERMCAP_md="${fg_bold[blue]}"   # turn on bold (extra bright) mode
export LESS_TERMCAP_me="${reset_color}"     # turn of all attributes
export LESS_TERMCAP_se="${reset_color}"     # exit standout mode
export LESS_TERMCAP_so="${fg[yellow]}${bg[blue]}"   # begin standout mode
export LESS_TERMCAP_ue="${reset_color}"     # exit underline mode
export LESS_TERMCAP_us="${fg[magenta]}"     # begin underline mode


# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# GO
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

export GOPATH=$HOME/Code/go
export PATH=$PATH:$GOPATH/bin


# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# TMUX
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

alias tmux='tmux -2'

if which tmux >/dev/null 2>&1; then
    # if not inside a tmux session, and if no session is started, start a new session
    test -z "$TMUX" && (tmux -2 attach || tmux -2 new-session)
fi


#+++++++++++++++++++++++++++++++++++++
# FUNCTIONS
#+++++++++++++++++++++++++++++++++++++

function pdfpextr()
{
    # this function uses 3 arguments:
    #     $1 is the first page of the range to extract
    #     $2 is the last page of the range to extract
    #     $3 is the input file
    #     output file will be named "inputfile_pXX-pYY.pdf"
    gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER \
       -dFirstPage=${1} \
       -dLastPage=${2} \
       -sOutputFile=${3%.pdf}_p${1}-p${2}.pdf \
       ${3}
}

function filter_log()
{
    sed -n /${1}/p ${2}
}

function base64decode()
{
    echo -n "$1" | base64 -d | xxd
}

function string2hex()
{
    echo -n ${1} | xxd -p -g0 -c256
}

function int2ip()
{
    python -c "import struct,socket; print(socket.inet_ntoa(struct.pack('!I', ${1})))"
}

function ip2int()
{
    python -c "import struct,socket; print(struct.unpack('!I', socket.inet_aton('${1}'))[0])"
}

function socks()
{
    ssh -f -N -D 8080 ${1}
    echo 'connect to localhost:8080'
}
