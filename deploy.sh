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

# --- Node.js + npm setup ---
if ! command -v node >/dev/null 2>&1 || ! command -v npm >/dev/null 2>&1; then
  log "Node.js and/or npm not found. Installing..."

  # Use NodeSource (recommended for Raspberry Pi OS / Debian-based distros)
  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
  sudo apt-get install -y nodejs

  log "Installed Node.js $(node -v), npm $(npm -v)"
else
  log "Node.js $(node -v) and npm $(npm -v) already installed"
fi

# --- Remove Gemfile.lock ---
rm Gemfile.lock

# --- Ruby dependencies ---
log "bundle install --redownload"
bundle install --redownload

# --- Rubee with React ---
log "preparing rubee with react"
RACK_ENV=production rubee react prepare

# --- ES build ---
RACK_ENV=production rubee react build

# --- Database migrations ---
log "migrations"
RACK_ENV=production rubee db run:all

# --- Restart Rubee server ---
log "restarting rubee server"
# rubee stop || true
RACK_ENV=production WEB_CONCURRENCY=4 rubee start > log/production.log 2>&1 &


log "done"
