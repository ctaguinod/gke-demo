#!/bin/bash
. set-vars.sh

# Set Shared Project
gcloud config set project $PROJECT_ID
SHARED_CONTEXT=`kubectl config get-contexts | grep $CLUSTER_NAME | awk '{print $2;}'`
kubectl config use-context $SHARED_CONTEXT

# Deploy observability addons
# grafana
kubectl apply -f istio-$ISTIO_VERSION/install/kubernetes/addons/grafana.yaml
# prometheus
kubectl apply -f istio-$ISTIO_VERSION/install/kubernetes/addons/prometheus.yaml
# servicegraph
kubectl apply -f istio-$ISTIO_VERSION/install/kubernetes/addons/servicegraph.yaml
# zipkin
kubectl apply -f istio-$ISTIO_VERSION/install/kubernetes/addons/zipkin.yaml
kubectl apply -f istio-$ISTIO_VERSION/install/kubernetes/addons/zipkin-to-stackdriver.yaml

