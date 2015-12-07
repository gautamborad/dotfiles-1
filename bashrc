. ~/.dotfiles/bash/env
. ~/.dotfiles/bash/config
. ~/.dotfiles/bash/aliases

# rbenv, if present
if hash rbenv 2>/dev/null; then
    eval "$(rbenv init -)"
fi

# gpg
GPG_AGENT=$(which gpg-agent)
GPG_TTY=`tty`
export GPG_TTY

if [ -f ${GPG_AGENT} ]; then
    . ~/.dotfiles/bash/gpg
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
