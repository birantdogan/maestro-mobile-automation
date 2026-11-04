#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Do not start another connection if port 5037 is occupied
if ss -ltn '( sport = :5037 )' | grep -q LISTEN; then
    echo "WSL ADB port 5037 is already in use."
    exit 0
fi

# Start ADB forwarding independently of the terminal
setsid -f bash "$SCRIPT_DIR/connect-adb.sh" \
    > /tmp/maestro-adb.log 2>&1 < /dev/null

echo "WSL ADB forwarding startup requested."
