#!/bin/bash
set -e

# Load rbenv if installed via shell config
export HOME=/home/oleg
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - bash)"  # or "zsh" if using zsh

log() {
  echo "[$(date '+%H:%M:%S')] $*"
}

sudo chown -R oleg:oleg ~/.rbenv

log "bundle install --redownload"
bundle install --redownload

log "preparing rubee with react"
RACK_ENV=production rubee react prepare

log "migrations"
RACK_ENV=production rubee db run:all

log "restarting rubee server"
rubee stop || true
RACK_ENV=production WEB_CONCURRENCY=3 rubee start > /dev/null 2>&1 &

log "done"
