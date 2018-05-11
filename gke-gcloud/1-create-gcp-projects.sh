#!/bin/bash
. set-vars.sh

becho() {
  echo ". $(tput bold)" "$*" "$(tput sgr0)";
}
err() {
  echo "$*" >&2;
}

if [ "$GCP_BILLING_ACCOUNT" == "0X0X0X-0X0X0X-0X0X0X" ]; 
  then
    becho "Billing Account $GCP_BILLING_ACCOUNT is Invalid, Change to Valid Billing ID in set-vars.sh and re run this command."
    exit

    else

      becho "Creating GCP Project $DEV_PROJECT_ID..."
      gcloud projects create $DEV_PROJECT_ID
      
      becho "GCP Project $DEV_PROJECT_ID linking to Billing Account $GCP_BILLING_ACCOUNT..."
      gcloud beta billing projects link $DEV_PROJECT_ID --billing-account $GCP_BILLING_ACCOUNT
      gcloud config set project $DEV_PROJECT_ID
      gcloud config set compute/zone $DEV_ZONE

      becho "Creating GCP Project $PROD_PROJECT_ID..."
      gcloud projects create $PROD_PROJECT_ID
      
      becho "GCP Project $PROD_PROJECT_ID linking to Billing Account $GCP_BILLING_ACCOUNT..."
      gcloud beta billing projects link $PROD_PROJECT_ID --billing-account $GCP_BILLING_ACCOUNT
      gcloud config set project $PROD_PROJECT_ID
      gcloud config set compute/zone $PROD_ZONE

      becho "Creating GCP Project $SHARED_PROJECT_ID..."
      gcloud projects create $SHARED_PROJECT_ID
      
      becho "GCP Project $SHARED_PROJECT_ID linking to Billing Account $GCP_BILLING_ACCOUNT..."
      gcloud beta billing projects link $SHARED_PROJECT_ID --billing-account $GCP_BILLING_ACCOUNT
      gcloud config set project $SHARED_PROJECT_ID
      gcloud config set compute/zone $SHARED_ZONE
fi
