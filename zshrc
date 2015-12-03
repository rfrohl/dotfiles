zstyle :compinstall filename "$HOME/.zshrc"

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
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS

# completion
autoload -U compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' max-errors 10

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
