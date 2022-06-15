export PROFILE_IMPORTED=1

if [[ "$OSTYPE" =~ ^darwin* ]]; then
  export BASH_SILENCE_DEPRECATION_WARNING=1
  [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
fi

[ -s ~/.bashrc ] && . ~/.bashrc;

[ -s "/home/linuxbrew/.linuxbrew/bin/brew" ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export GOPATH="$HOME/go"
export NPM_PACKAGES="${HOME}/.npm_packages"

[ -d "$HOME/bin" ] &&            export PATH="$HOME/bin:$PATH"
[ -d "$NPM_PACKAGES/bin" ] &&    export PATH="$NPM_PACKAGES/bin:$PATH"
[ -d "$GOPATH/bin" ] &&          export PATH="$GOPATH/bin:$PATH"
[ -d "$GOPATH/.local/bin" ] &&   export PATH="$PATH:$HOME/.local/bin"

if [ -d "~/bin/dotnet" ]; then
  export PATH=~/bin/dotnet:$PATH
  export DOTNET_ROOT=~/bin/dotnet
fi

KREWPATH=${KREW_ROOT:-$HOME/.krew}
[ -d "$KREWPATH" ] && export PATH="$KREWPATH/bin:$PATH"
