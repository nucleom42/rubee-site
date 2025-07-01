#!/bin/bash
set -euo pipefail

# === CONFIG ===
APP_NAME="rubee-app"
LIVE_PORT=80                # Public port exposed on host
INTERNAL_PORT=7000          # Port app listens to inside container
TEMP_PORT=7001              # Temporary internal port for health check
CONTAINER_LIVE="rubee-container"
CONTAINER_TEMP="rubee-temp"
TAG="rubee-app:$(date +%s)" # Unique image tag

log() {
  echo "[$(date '+%H:%M:%S')] $*"
}

log "🚧 Building new image..."
podman build -t "$TAG" .

log "🚀 Running temporary container on port $TEMP_PORT..."
podman run -d --rm \
  --name "$CONTAINER_TEMP" \
  -p "$TEMP_PORT:$INTERNAL_PORT" \
  "$TAG"

log "⏳ Waiting for temporary container to be healthy..."
for i in {1..10}; do
  if curl -s "http://localhost:$TEMP_PORT" >/dev/null; then
    log "✅ Temporary container is healthy."
    break
  else
    log "⏳ Still waiting..."
    sleep 2
  fi
done

log "🧹 Stopping and removing old container (if exists)..."
podman stop "$CONTAINER_LIVE" 2>/dev/null || true
podman rm "$CONTAINER_LIVE" 2>/dev/null || true

log "🔁 Starting new live container on port $LIVE_PORT..."
podman run -d \
  --restart=unless-stopped \
  --name "$CONTAINER_LIVE" \
  -p "$LIVE_PORT:$INTERNAL_PORT" \
  "$TAG"

log "🧼 Cleaning up temporary container..."
podman stop "$CONTAINER_TEMP" 2>/dev/null || true
podman rm "$CONTAINER_TEMP" 2>/dev/null || true

log "🧹 Pruning unused images..."
podman image prune -f

log "✅ Deployment complete. App is live at http://localhost:$LIVE_PORT"
