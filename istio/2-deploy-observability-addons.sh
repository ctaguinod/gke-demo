#!/bin/bash
. set-vars.sh

# Set Shared Project
gcloud config set project $PROJECT_ID
SHARED_CONTEXT=`kubectl config get-contexts | grep $CLUSTER_NAME | awk '{print $2;}'`
kubectl config use-context $SHARED_CONTEXT

# Deploy observability addons
# Grafana - port 3000
kubectl apply -f istio-$ISTIO_VERSION/install/kubernetes/addons/grafana.yaml

# Prometheus - 9090
kubectl apply -f istio-$ISTIO_VERSION/install/kubernetes/addons/prometheus.yaml

# Servicegraph - 8088
kubectl apply -f istio-$ISTIO_VERSION/install/kubernetes/addons/servicegraph.yaml

# Zipkin - port 9411
#kubectl apply -f istio-$ISTIO_VERSION/install/kubernetes/addons/zipkin.yaml
#kubectl apply -f istio-$ISTIO_VERSION/install/kubernetes/addons/zipkin-to-stackdriver.yaml

# Jaeger - port 16686
#https://raw.githubusercontent.com/jaegertracing/jaeger-kubernetes/master/all-in-one/jaeger-all-in-one-template.yml
kubectl apply -n istio-system -f jaeger-all-in-one-template.yml 
