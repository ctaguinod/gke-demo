#!/bin/bash
. set-vars.sh

# Create Halyard IAM Service Account
gcloud config set project $SHARED_PROJECT_ID
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable iam.googleapis.com
gcloud iam service-accounts create $HALYARD_SA --project=$SHARED_PROJECT_ID --display-name $HALYARD_SA
gcloud projects add-iam-policy-binding $SHARED_PROJECT_ID --member serviceAccount:$HALYARD_SA_EMAIL --role roles/iam.serviceAccountKeyAdmin
gcloud projects add-iam-policy-binding $SHARED_PROJECT_ID --member serviceAccount:$HALYARD_SA_EMAIL --role roles/container.admin

# Create Spinnaker Service Account
gcloud iam service-accounts create $SPINNAKER_SA --project=$SHARED_PROJECT_ID --display-name $SPINNAKER_SA
gcloud projects add-iam-policy-binding $SHARED_PROJECT_ID --member serviceAccount:$SPINNAKER_SA_EMAIL --role roles/storage.admin 
gcloud projects add-iam-policy-binding $SHARED_PROJECT_ID --member serviceAccount:$SPINNAKER_SA_EMAIL --role roles/browser

# Provision Halyard Instance
gcloud compute instances create $HALYARD_INSTANCE \
	--project=$SHARED_PROJECT_ID \
	--zone=$HALYARD_ZONE \
	--scopes=cloud-platform \
	--service-account=$HALYARD_SA_EMAIL \
	--image-project=ubuntu-os-cloud \
	--image-family=ubuntu-1604-lts \
	--machine-type=$HALYARD_MACHINE_TYPE
