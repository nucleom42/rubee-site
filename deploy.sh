log() {
  echo "[$(date '+%H:%M:%S')] $*"
}

log "bundler install --redownload"
bundle install --redownload

log "restarting rubee server"
RACK_ENV=production
rubee stop
rubee start

log "preparing rubee with react"
rubee react prepare

log "migrations"
rubee db run:all

log "done"