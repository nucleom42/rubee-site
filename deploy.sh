#!/bin/bash
set -euo pipefail

# === CONFIG ===
APP_NAME="rubee-app"
INTERNAL_PORT=7000           # App port inside container
PORT_A=7000                  # Live port A
PORT_B=7001                  # Live port B
CONTAINER_A="rubee-a"
CONTAINER_B="rubee-b"
TAG="rubee-app:$(date +%s)"

log() {
  echo "[$(date '+%H:%M:%S')] $*"
}

# === Determine active container and ports ===
if podman ps --format '{{.Names}}' | grep -q "$CONTAINER_A"; then
  CURRENT="$CONTAINER_A"
  NEW="$CONTAINER_B"
  CURRENT_PORT="$PORT_A"
  NEW_PORT="$PORT_B"
else
  CURRENT="$CONTAINER_B"
  NEW="$CONTAINER_A"
  CURRENT_PORT="$PORT_B"
  NEW_PORT="$PORT_A"
fi

log "🔍 Current live container is $CURRENT on port $CURRENT_PORT"
log "🆕 New container will be $NEW on port $NEW_PORT"

# === Build new image ===
log "🚧 Building image $TAG..."
podman build -t "$TAG" .

# === Start new container on alternate port ===
log "🚀 Starting new container $NEW on port $NEW_PORT..."
podman run -d --rm \
  --name "$NEW" \
  -p "$NEW_PORT:$INTERNAL_PORT" \
  "$TAG"

# === Wait for health check ===
log "⏳ Waiting for new container to become healthy..."
for i in {1..10}; do
  if curl -s "http://localhost:$NEW_PORT" >/dev/null; then
    log "✅ New container is healthy."
    break
  else
    log "⏳ Still waiting..."
    sleep 2
  fi
done

# === Switch reverse proxy ===
log "🔁 Switching Nginx to new port $NEW_PORT..."
sed -i "s/localhost:$CURRENT_PORT/localhost:$NEW_PORT/" /etc/nginx/sites-enabled/rubee.conf
nginx -s reload

# === Stop and remove old container ===
log "🧹 Stopping old container $CURRENT..."
podman stop "$CURRENT" || true
podman rm "$CURRENT" || true

log "🧼 Pruning unused images..."
podman image prune -f

log "✅ Deployment complete. Live on port $NEW_PORT via Nginx"
