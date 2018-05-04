#!/bin/bash
. set-vars.sh

# Set Shared Project
gcloud config set project $PROJECT_ID
CONTEXT=`kubectl config get-contexts | grep $CLUSTER_NAME | awk '{print $2;}'`
kubectl config use-context $CONTEXT

echo "Bookinfo URL: http://`kubectl get ingress gateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}'`/productpage"
