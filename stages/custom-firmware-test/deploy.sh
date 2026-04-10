#!/bin/bash
set -e
echo "=== Deploying to RPi4 ==="
echo "Target: ${DEPLOY_TARGET:?DEPLOY_TARGET not set}"
echo "User: ${DEPLOY_USER:?DEPLOY_USER not set}"

BINARY="build/firmware"
if [ ! -f "$BINARY" ]; then
    echo "ERROR: $BINARY not found"
    exit 1
fi

echo "Binary info:"
file "$BINARY"

echo "Deploying to ${DEPLOY_TARGET}..."
scp -o ProxyJump=mt6000 "$BINARY" "${DEPLOY_USER}@${DEPLOY_TARGET}:/tmp/firmware"

echo "Verifying on target..."
ssh -o ProxyJump=mt6000 "${DEPLOY_USER}@${DEPLOY_TARGET}" "/tmp/firmware"
echo "Deployment successful"
