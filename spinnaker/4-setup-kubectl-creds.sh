#!/bin/bash
. set-vars.sh

# Install Kubectl
KUBECTL_LATEST=$(shell curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(KUBECTL_LATEST)/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/kubectl


# Configure Credentials for Shared Cluster
# Generate ~/.kube/config
gcloud config set project $SHARED_PROJECT_ID
gcloud container clusters get-credentials $SHARED_CLUSTER_NAME \
	--zone=$SHARED_ZONE --project $SHARED_PROJECT_ID
# Create RBAC Service Account 
kubectl create -f k8s/spinnaker-service-account.yaml
# Updated ~/.kube/config to use Token
sa=$(kubectl get secrets | grep spinnaker-service-account | awk '{print $1;}')
token=$(kubectl get secret $sa -o json  | jq -r .data.token  | base64 -d)
currentcontext=$(kubectl config current-context)
kubectl config set-credentials $currentcontext --token=$token


# Configure Credentials for Dev Cluster
# Generate ~/.kube/config
gcloud config set project $DEV_PROJECT_ID
gcloud container clusters get-credentials $DEV_CLUSTER_NAME \
    --zone=$DEV_ZONE --project $DEV_PROJECT_ID
# Create RBAC Service Account 
kubectl create -f k8s/spinnaker-service-account.yaml
# Updated ~/.kube/config to use Token
sa=$(kubectl get secrets | grep spinnaker-service-account | awk '{print $1;}')
token=$(kubectl get secret $sa -o json  | jq -r .data.token  | base64 -d)
currentcontext=$(kubectl config current-context)
kubectl config set-credentials $currentcontext --token=$token


# Configure Credentials for Prod Cluster
# Generate ~/.kube/config
gcloud config set project $PROD_PROJECT_ID
gcloud container clusters get-credentials $PROD_CLUSTER_NAME \
    --zone=$PROD_ZONE --project $PROD_PROJECT_ID
# Create RBAC Service Account 
kubectl create -f k8s/spinnaker-service-account.yaml
# Updated ~/.kube/config to use Token
sa=$(kubectl get secrets | grep spinnaker-service-account | awk '{print $1;}')
token=$(kubectl get secret $sa -o json  | jq -r .data.token  | base64 -d)
currentcontext=$(kubectl config current-context)
kubectl config set-credentials $currentcontext --token=$token

