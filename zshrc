# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' max-errors 10
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit && compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=12000
#setopt appendhistory
setopt autocd correct extendedglob nomatch histignorealldups
setopt incappendhistory
unsetopt beep notify
bindkey -e
# End of lines configured by zsh-newuser-install

# Initialize colors.
autoload -U colors && colors

# prompt with current path on the right side
RPROMPT=' %(?.%(!.%/.%~).:()'

# left side
#PROMPT="%{$fg[green]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%}[%!]%# "
#PROMPT="%{$fg[green]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%} %(!.#.$) "
source "$HOME/.dotfiles/zsh/git-prompt/zshrc.sh"
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

# '--color=auto' == Farben | '-F' == '/'->Verzeichnis && '*'->ausfuehrbar | -v == sortiert
alias ls='ls --color=auto -F -v'
alias la='ls -a'
alias ll='ls -l'

alias hd='hexdump -C -v'

# export GREP_OPTIONS='--color=auto --line-number'
alias grep="grep --color=auto --line-number --recursive"

alias gdb="gdb -quiet"

alias make="make -j4"

alias df="df --human-readable"

alias apg='/usr/bin/apg -a1 -m16 -x16 -n1 -MNL /dev/random'
alias apg_short='/usr/bin/apg -a0 -m10 -x10 -n1 -MNL /dev/urandom'

alias tmux='tmux -2'

alias objdump='objdump -d'

alias gcc="gcc -g"

alias vim="vim -p"

alias APT="sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade"

# suffix-alias
alias -s txt=vim tex=gvim cc=vim cpp=vim h=vim hpp=vim pl=vim pdf=evince


# ++++++++++++++++++++++++++++++++++++
# Ruby
# ++++++++++++++++++++++++++++++++++++

# Ruby gem
export PATH="$PATH:$HOME/.gem/ruby/2.0.0/bin"

# RAILS
#export PATH="$PATH:/home/korso/.gem/jruby/1.8/bin"

# Rbenv
#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# jRuby
#export JRUBY_OPTS="--1.9"
#alias jruby="jruby-1.6.5.1"

# man 5 terminfo; man console_codes
export LESS_TERMCAP_mb="${fg[cyan]}"        # turn on blinking
export LESS_TERMCAP_md="${fg_bold[blue]}"   # turn on bold (extra bright) mode
export LESS_TERMCAP_me="${reset_color}"     # turn of all attributes
export LESS_TERMCAP_se="${reset_color}"     # exit standout mode
export LESS_TERMCAP_so="${fg[yellow]}${bg[blue]}"   # begin standout mode
export LESS_TERMCAP_ue="${reset_color}"     # exit underline mode
export LESS_TERMCAP_us="${fg[magenta]}"     # begin underline mode


######################################
# SSH
######################################

alias socks_ssh='ssh -N -D 8080 server'
