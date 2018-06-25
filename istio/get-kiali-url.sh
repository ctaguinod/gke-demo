#!/bin/bash
. set-vars.sh

# Set Shared Project
gcloud config set project $PROJECT_ID
CONTEXT=`kubectl config get-contexts | grep $CLUSTER_NAME | awk '{print $2;}'`
kubectl config use-context $CONTEXT

echo "Kiali URL: http://`kubectl -n istio-system get ingress kiali -o jsonpath='{.status.loadBalancer.ingress[0].ip}'`"
echo "user: admin"
echo "pass: admin"
