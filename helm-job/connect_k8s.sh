#!/bin/sh
set -euo pipefail

function log {
  echo "$@"
  return 0
}

# Install az cli
log "✅ installing the az cli..."
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
log "✅ az cli successfully installed"

# Authenticate to az
log "✅ authenticating to az..."
azure login --service-principal -u "${CLIENT_ID}" -p "${CLIENT_SECRET}" --tenant "${TENANT_ID}"
log "✅ successfully authenticated to az..."

# connect to azure kubernetes cluster
log "✅ connecting to the kubernetes cluster..."
az aks get-credentials --resource-group "${RESOURCE_GROUP}" --name "${CLUSTER_NAME}" --overwrite-existing
log "✅ successfully connected to ${CLUSTER_NAME}"

sleep 1m