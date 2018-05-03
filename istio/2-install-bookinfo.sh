#!/bin/bash
. set-vars.sh

# Set Shared Project
gcloud config set project $PROJECT_ID
CONTEXT=`kubectl config get-contexts | grep $CLUSTER_NAME | awk '{print $2;}'`
kubectl config use-context $CONTEXT

# Install Bookinfo from GCR
sed "s/SHARED_PROJECT_ID/$SHARED_PROJECT_ID/" ../bookinfo/k8s/bookinfo-deployments-services-template.yaml > bookinfo-deployments-services.yaml
./istio-$ISTIO_VERSION/bin/istioctl kube-inject -f bookinfo-deployments-services.yaml | kubectl apply -f -
./istio-$ISTIO_VERSION/bin/istioctl kube-inject -f bookinfo-ingress.yaml | kubectl apply -f -
./istio-$ISTIO_VERSION/bin/istioctl kube-inject -f bookinfo-services-spinnaker.yaml | kubectl apply -f -

echo "Bookinfo URL: http://`kubectl get ingress gateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}'`/productpage"
