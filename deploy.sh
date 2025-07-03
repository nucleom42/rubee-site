
#!/bin/bash
set -e

# Load rbenv if installed via shell config
export HOME=/home/oleg
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - bash)"  # or "zsh" if using zsh

log() {
  echo "[$(date '+%H:%M:%S')] $*"
}

log "bundler install --redownload"
bundle install --redownload > /dev/null 2>&1

log "preparing rubee with react"
rubee react prepare > /dev/null 2>&1

log "migrations"
rubee db run:all > /dev/null 2>&1

echo "::group::Restarting Rubee Server"
log "restarting rubee server"
rubee stop > /dev/null 2>&1 || true
rubee start > /dev/null 2>&1 &
echo "::endgroup::"
log "done"

