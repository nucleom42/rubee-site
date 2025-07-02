#!/bin/bash

# Determine which container is active
ACTIVE_PORT=$(grep -o '700[12]' /etc/nginx/sites-enabled/rubee)
if [ "$ACTIVE_PORT" == "7001" ]; then
  OLD_NAME="rubee-a"
  NEW_NAME="rubee-b"
  NEW_PORT="7002"
else
  OLD_NAME="rubee-b"
  NEW_NAME="rubee-a"
  NEW_PORT="7001"
fi

echo "Deploying new version to $NEW_NAME on port $NEW_PORT"

# Build and start new container
podman build -t rubee-app-image:new .

# Tag the new image with a stable name to protect it
podman tag rubee-app-image:new rubee-app-image:live

# Remove container if already exists
podman rm -f $NEW_NAME 2>/dev/null

# Run new container on dynamic external port, internal always 7000
podman run -d --name $NEW_NAME --restart=always -p 7000:$NEW_PORT rubee-app-image:live

# Wait for boot
echo "Waiting for app to be ready..."
sleep 5

# Health check
if curl -f http://localhost:$NEW_PORT >/dev/null 2>&1; then
  echo "App passed health check. Switching NGINX to port $NEW_PORT"

  sudo ln -sf /etc/nginx/sites-available/rubee-$NEW_PORT /etc/nginx/sites-enabled/rubee
  sudo nginx -s reload

  echo "Stopping old container $OLD_NAME"
  podman stop $OLD_NAME
  podman rm $OLD_NAME

  echo "Pruning unused containers and dangling images..."
  # Remove all exited containers except current
  podman ps -a --format '{{.Names}}' | grep -vE "^($NEW_NAME|$OLD_NAME)$" | xargs -r podman rm -f

  # Remove all images except live one
  podman images --format '{{.Repository}}:{{.Tag}} {{.ID}}' | grep -v 'rubee-app-image:live' | awk '{print $2}' | xargs -r podman rmi -f
else
  echo "Health check failed! Aborting deployment."
  podman stop $NEW_NAME
  podman rm $NEW_NAME
  exit 1
fi
