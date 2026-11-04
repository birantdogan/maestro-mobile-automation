
#!/usr/bin/env bash
set -euo pipefail

# Find the Windows host IP from WSL
WINDOWS_HOST_IP=$(ip -4 route show default | awk '{print $3; exit}')

if [[ -z "$WINDOWS_HOST_IP" ]]; then
  echo "ERROR: Windows host IP could not be found."
  exit 1
fi

# Check whether port 5037 is already occupied
if (echo > /dev/tcp/127.0.0.1/5037) 2>/dev/null; then
  echo "Port 5037 is already in use. ADB connection may already be active."
  exit 0
fi

echo "Connecting WSL ADB to Windows at ${WINDOWS_HOST_IP}:5037"

# Forward local ADB connections to Windows
exec socat TCP-LISTEN:5037,bind=127.0.0.1,reuseaddr,fork \
  "TCP:${WINDOWS_HOST_IP}:5037"
