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


echo "::group::Restarting Rubee Server"
log "restarting rubee server"
nohup sudo pkill rubee > /dev/null 2>&1 &
nohup rubee start > /dev/null 2>&1 &
echo "::endgroup::"

log "done"
