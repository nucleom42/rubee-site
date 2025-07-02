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
podman rm -f $NEW_NAME 2>/dev/null
podman run -d --name $NEW_NAME --restart=always -p $NEW_PORT:80 rubee-app-image:new

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
else
  echo "Health check failed! Aborting deployment."
  podman stop $NEW_NAME
  podman rm $NEW_NAME
  exit 1
fi
