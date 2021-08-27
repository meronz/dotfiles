# Exit immediately if shell is not interactive
if [[ $- != *i* ]] ; then return; fi

[ "$OSTYPE" == "msys" ] && export TERM=cygwin

##COLORS
Color_Off='\[\e[0m\]'
IRed='\[\e[0;91m\]'
IBlue='\[\e[0;94m\]'
IWhite='\[\e[0;97m\]'
##COLORS END

LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;40:sg=30;40:ca=30;40:tw=30;40:ow=34;40:st=37;40:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';

# History and autocompletion options
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s checkwinsize
bind  'set skip-completed-text on'
bind  'set completion-ignore-case on'

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

# Default Editor
EDITOR="vim"

## Aliases
if [ "$OSTYPE" == "linux-gnu" ]; then
  alias ls='ls -ah --color=auto'
  alias ll='ls -lah --color=auto'
  alias dir='dir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias dmesg='dmesg --color=always'
  aptprog='apt-get'
  [ -x /usr/bin/apt ] && aptprog='apt'
  alias apti="sudo $aptprog install -y"
  alias aptp="sudo $aptprog purge -y"
  alias aptu="sudo $aptprog update; sudo $aptprog dist-upgrade"
  alias ps='ps'
  alias dft='df --total -h | grep total'
  alias poweroff='sudo poweroff'
elif [[ "$OSTYPE" =~ ^darwin* ]]; then
  alias ls='ls -ahG'
  alias ll='ls -lahG'
else
  alias ll='ls -l'
fi

alias less='less -r'
md () { mkdir -p "$@" && cd "$@"; }
alias command_present="command -v $1 &>/dev/null"

# x - archive extractor
# usage: x <file>
x ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       rar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.xz)        unxz $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Setup fzf
if [[ ! "$PATH" == *~/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}~/.fzf/bin"
fi

[[ $- == *i* ]] && source "~/.fzf/shell/completion.bash" 2> /dev/null

[ -f "~/.fzf/shell/key-bindings.bash" ] && source "~/.fzf/shell/key-bindings.bash"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash


# Bash Prompt
prompt ()
{
  command_present git && \
    cur_branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')

  [ -z $VIRTUAL_ENV ] || cur_env='(`basename $VIRTUAL_ENV`)'

  PS1=' \$ '
  # Save history on each command
  history -a; history -c; history -r;
  PS1="$cur_env$IBlue[\W]$IRed$cur_branch$Color_Off\n$IWhite\$$Color_Off " # Small
}

PROMPT_COMMAND='prompt'
