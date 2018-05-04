#!/bin/bash
. set-vars.sh

# Dev Cluster
DEV_CONTEXT=`kubectl config get-contexts | grep $DEV_CLUSTER_NAME | awk '{print $2;}'`
kubectl config use-context $DEV_CONTEXT
kubectl apply -f ../helloworld/k8s/service-helloworld-dev-lb.yaml

# Prod Cluster
PROD_CONTEXT=`kubectl config get-contexts | grep $PROD_CLUSTER_NAME | awk '{print $2;}'`
kubectl config use-context $PROD_CONTEXT
kubectl apply -f ../helloworld/k8s/service-helloworld-prod-lb.yaml



