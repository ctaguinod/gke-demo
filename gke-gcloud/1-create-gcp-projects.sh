#!/bin/bash
. set-vars.sh

gcloud projects create $DEV_PROJECT_ID
gcloud beta billing projects link $DEV_PROJECT_ID --billing-account $GCP_BILLING_ACCOUNT
gcloud config set project $DEV_PROJECT_ID
gcloud config set compute/zone $DEV_ZONE
gcloud projects create $PROD_PROJECT_ID
gcloud beta billing projects link $PROD_PROJECT_ID --billing-account $GCP_BILLING_ACCOUNT
gcloud config set project $PROD_PROJECT_ID
gcloud config set compute/zone $PROD_ZONE
gcloud projects create $SHARED_PROJECT_ID
gcloud beta billing projects link $SHARED_PROJECT_ID --billing-account $GCP_BILLING_ACCOUNT
gcloud config set project $SHARED_PROJECT_ID
gcloud config set compute/zone $SHARED_ZONE
