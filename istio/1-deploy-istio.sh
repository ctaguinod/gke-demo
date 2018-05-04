#!/bin/bash
. set-vars.sh

# Set Shared Project
gcloud config set project $PROJECT_ID
SHARED_CONTEXT=`kubectl config get-contexts | grep $CLUSTER_NAME | awk '{print $2;}'`
kubectl config use-context $SHARED_CONTEXT

# Create RBAC Admin for current user
kubectl create clusterrolebinding user-admin-binding --clusterrole=cluster-admin --user=$(gcloud config get-value core/account)
kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=$(gcloud config get-value core/account)

# Install istio-auth
curl -L https://git.io/getLatestIstio | ISTIO_VERSION=$ISTIO_VERSION sh -
kubectl apply -f istio-$ISTIO_VERSION/install/kubernetes/istio-auth.yaml

# Setup Automatic Sidecar Injection
# https://istio.io/docs/setup/kubernetes/sidecar-injection.html#automatic-sidecar-injection
kubectl apply -f istio-$ISTIO_VERSION/install/kubernetes/istio.yaml
./istio-$ISTIO_VERSION/install/kubernetes/webhook-create-signed-cert.sh \
	--service istio-sidecar-injector \
	--namespace istio-system \
	--secret sidecar-injector-certs

kubectl apply -f istio-$ISTIO_VERSION/install/kubernetes/istio-sidecar-injector-configmap-release.yaml

cat istio-$ISTIO_VERSION/install/kubernetes/istio-sidecar-injector.yaml | \
	./istio-$ISTIO_VERSION/install/kubernetes/webhook-patch-ca-bundle.sh > \
	./istio-$ISTIO_VERSION/install/kubernetes/istio-sidecar-injector-with-ca-bundle.yaml

kubectl apply -f istio-$ISTIO_VERSION/install/kubernetes/istio-sidecar-injector-with-ca-bundle.yaml

kubectl -n istio-system get deployment -listio=sidecar-injector

# Label default namespace for auto sidecar injection
kubectl get namespace -L istio-injection
kubectl label namespace default istio-injection=enabled
kubectl get namespace -L istio-injection
