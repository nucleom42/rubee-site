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

log "restarting rubee server"
rubee stop || true
rubee start

log "preparing rubee with react"
rubee react prepare

log "migrations"
rubee db run:all

log "done"
