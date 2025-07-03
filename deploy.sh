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
bundle install --redownload

log "preparing rubee with react"
rubee react prepare

log "migrations"
rubee db run:all

log "restarting rubee server"
echo "::group::Restart Rubee"
rubee stop || true /dev/null
rubee start > /dev/null
echo "::endgroup::"

log "done"

