#!/bin/bash
# GKE Cluster and GCP Project to Install Istio
CLUSTER_NAME=dev
PROJECT_ID=$USER-$CLUSTER_NAME
# GCP Project with Container Registry
SHARED_CLUSTER_NAME=shared
SHARED_PROJECT_ID=$USER-$SHARED_CLUSTER_NAME
# LATEST RELEASE: https://github.com/istio/istio/releases
ISTIO_VERSION=0.7.1
