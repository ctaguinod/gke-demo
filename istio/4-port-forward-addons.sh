#!/bin/bash
. set-vars.sh

# Set Shared Project
gcloud config set project $PROJECT_ID
CONTEXT=`kubectl config get-contexts | grep $CLUSTER_NAME | awk '{print $2;}'`
kubectl config use-context $CONTEXT
kubectl get nodes
kubectl get ns

#ZIPKIN_POD_NAME=`kubectl -n istio-system get pod -l app=zipkin -o jsonpath='{.items[0].metadata.name}'`
#kubectl -n istio-system port-forward $ZIPKIN_POD_NAME 9411:9411 & 
#echo "Zipkin URL/Port: http://localhost:9411"

SERVICEGRAPH_POD_NAME=`kubectl -n istio-system get pod -l app=servicegraph -o jsonpath='{.items[0].metadata.name}'`
kubectl -n istio-system port-forward $SERVICEGRAPH_POD_NAME 8088:8088 & 
echo "Dotviz URL/Port: http://localhost:8088/dotviz"

GRAFANA_POD_NAME=`kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}'`
kubectl -n istio-system port-forward $GRAFANA_POD_NAME 3000:3000 &
echo "Grafana URL/Port: http://localhost:3000"

PROMETHEUS_POD_NAME=`kubectl -n istio-system get pod -l app=prometheus -o jsonpath='{.items[0].metadata.name}'`
kubectl -n istio-system port-forward $PROMETHEUS_POD_NAME 9090:9090 &
echo "Prometheus URL/Port: http://localhost:9090/graph"

JAEGER_POD_NAME=`kubectl -n istio-system get pod -l app=jaeger -o jsonpath='{.items[0].metadata.name}'`
kubectl -n istio-system port-forward $JAEGER_POD_NAME 16686:16686 &
echo "Prometheus URL/Port: http://localhost:16686"
