#!/bin/bash
. set-vars.sh

gcloud container clusters get-credentials $SHARED_CLUSTER_NAME --zone=$SHARED_ZONE --project $SHARED_PROJECT_ID
gcloud container clusters get-credentials $DEV_CLUSTER_NAME --zone=$DEV_ZONE --project $DEV_PROJECT_ID
gcloud container clusters get-credentials $PROD_CLUSTER_NAME --zone=$PROD_ZONE --project $PROD_PROJECT_ID
