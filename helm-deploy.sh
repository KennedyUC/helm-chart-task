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

sleep 2s

# Authenticate to az
log "✅ authenticating to az..."
az login --service-principal -u "${CLIENT_ID}" -p "${CLIENT_SECRET}" --tenant "${TENANT_ID}"
log "✅ successfully authenticated to az..."

sleep 2s

# connect to azure kubernetes cluster
log "✅ connecting to the kubernetes cluster..."
az aks get-credentials --resource-group "${RESOURCE_GROUP}" --name "${CLUSTER_NAME}" --overwrite-existing
log "✅ successfully connected to k8s cluster"

sleep 2s

# install kubectl
log "✅ installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
log "✅ kubectl successfully installed"

sleep 2s

# create namespace for the helm app
NS=$(kubectl get namespace $APP_NAME --ignore-not-found);
if [[ "$NS" ]]; then
  log "✅ Skipping creation of namespace $APP_NAME - already exists";
else
  log "✅ Creating namespace $APP_NAME";
  kubectl create namespace $APP_NAME;
fi;

sleep 2s

# deploy helm app
log "✅ deploying helm app from the helm chart package..."
helm repo add --username udagram --password $TOKEN helm-chart-task ${API_URL}/${PROJECT_ID}/packages/helm/stable
helm upgrade $APP_NAME helm-chart-task/${HELM_CHART} --install --values ${HELM_CHART}/values.yaml -n $APP_NAME
log "✅ $APP_NAME successfully deployed to k8s cluster"

sleep 1m

# view deployed app
log "✅ displaying the deployed app..."
helm list -n $APP_NAME

sleep 4m

kubectl get all -n $APP_NAME