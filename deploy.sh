#!/bin/bash
set -e

export HOME=/home/oleg
export PATH="$HOME/.rbenv/bin:$PATH"

# Load rbenv if it's installed
if command -v rbenv >/dev/null 2>&1; then
  eval "$(rbenv init - bash)"
fi

log() {
  echo "[$(date '+%H:%M:%S')] $*"
}

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
og "done"
