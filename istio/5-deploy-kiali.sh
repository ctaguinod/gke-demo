#!/bin/bash
. set-vars.sh

# Set Project
gcloud config set project $PROJECT_ID
CONTEXT=`kubectl config get-contexts | grep $CLUSTER_NAME | awk '{print $2;}'`
kubectl config use-context $CONTEXT

# Deploy kiali - https://github.com/kiali/kiali
git clone https://github.com/kiali/kiali.git

cat kiali/deploy/kubernetes/kiali-configmap.yaml | \
   VERSION_LABEL=master envsubst | kubectl create -n istio-system -f -

cat kiali/deploy/kubernetes/kiali-secrets.yaml | \
   VERSION_LABEL=master envsubst | kubectl create -n istio-system -f -

cat kiali/deploy/kubernetes/kiali.yaml | \
   IMAGE_NAME=kiali/kiali \
   IMAGE_VERSION=latest \
   NAMESPACE=istio-system \
   VERSION_LABEL=master \
   VERBOSE_MODE=4 envsubst | kubectl create -n istio-system -f -

echo "To Undeploy Run: cd kiali; make k8s-undeploy"
