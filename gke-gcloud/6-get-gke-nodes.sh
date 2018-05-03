#!/bin/bash
. set-vars.sh

DEV_CONTEXT=`kubectl config get-contexts | grep $DEV_CLUSTER_NAME | awk '{print $2;}'`
kubectl config use-context $DEV_CONTEXT
kubectl get nodes      

PROD_CONTEXT=`kubectl config get-contexts | grep $PROD_CLUSTER_NAME | awk '{print $2;}'`
kubectl config use-context $PROD_CONTEXT
kubectl get nodes      

SHARED_CONTEXT=`kubectl config get-contexts | grep $SHARED_CLUSTER_NAME | awk '{print $2;}'`
kubectl config use-context $SHARED_CONTEXT
kubectl get nodes      
