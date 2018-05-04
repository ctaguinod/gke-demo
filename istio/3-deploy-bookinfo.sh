#!/bin/bash
. set-vars.sh

# Set Shared Project
gcloud config set project $PROJECT_ID
CONTEXT=`kubectl config get-contexts | grep $CLUSTER_NAME | awk '{print $2;}'`
kubectl config use-context $CONTEXT

# Install Bookinfo from recently created repo in gcr.io

# Replace with correct GCP Project ID 
sed "s/SHARED_PROJECT_ID/$SHARED_PROJECT_ID/" ../bookinfo/k8s/bookinfo-deployments-services-template.yaml > bookinfo-deployments-services.yaml

# Use command below if GKE Cluster is not configured for automatic sidecar injection
# Deploy Bookinfo App with Services and Ingress 
# GKE Cluster NOT configured for automatic sidecar injection
#./istio-$ISTIO_VERSION/bin/istioctl kube-inject -f bookinfo-deployments-services.yaml | kubectl apply -f -
# GKE Cluster with automatic sidecar injection
kubectl apply -f bookinfo-deployments-services.yaml

# Deploy Services and Istio Ingress only - Bookinfo App deployed with Spinnaker
# GKE Cluster NOT configured for automatic sidecar injection
#./istio-$ISTIO_VERSION/bin/istioctl kube-inject -f bookinfo-ingress.yaml | kubectl apply -f -
#./istio-$ISTIO_VERSION/bin/istioctl kube-inject -f bookinfo-services-spinnaker.yaml | kubectl apply -f -
# GKE Cluster with automatic sidecar injection
#kubectl apply -f ../bookinfo/k8s/bookinfo-ingress.yaml
#kubectl apply -f ../bookinfo/k8s/bookinfo-services-spinnaker.yaml

echo "Bookinfo URL: http://`kubectl get ingress gateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}'`/productpage"
