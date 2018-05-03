#!/bin/bash

gcloud config set project $PROD_PROJECT_ID
gcloud services enable sourcerepo.googleapis.com
gcloud services enable cloudbuild.googleapis.com
gcloud services enable iam.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com
gcloud iam service-accounts create $PROD_GKE_SA --project $SHARED_PROJECT_ID --display-name $SHARED_GKE_SA
gcloud projects add-iam-policy-binding $PROD_PROJECT_ID --member serviceAccount:$SHARED_GKE_SA_EMAIL --role roles/storage.admin
gcloud projects add-iam-policy-binding $PROD_PROJECT_ID --member serviceAccount:$SHARED_GKE_SA_EMAIL --role roles/logging.logWriter
gcloud projects add-iam-policy-binding $PROD_PROJECT_ID --member serviceAccount:$SHARED_GKE_SA_EMAIL --role roles/monitoring.metricWriter
gcloud projects add-iam-policy-binding $PROD_PROJECT_ID --member serviceAccount:$SHARED_GKE_SA_EMAIL --role roles/container.admin
gcloud container clusters create $PROD_CLUSTER_NAME \
	--project $PROD_PROJECT_ID \
	--network "default" \
	--subnetwork "default" \
	--machine-type $PROD_MACHINE_TYPE \
	--zone $PROD_ZONE \
	--additional-zones $PROD_ZONE2 \
	--cluster-version=$PROD_CLUSTER_VERSION \
	--image-type="COS" \
	--disk-size $PROD_DISK_SIZE \
	--service-account $PROD_GKE_SA_EMAIL \
	--num-nodes $PROD_NUM_NODES \
	--min-nodes $PROD_MIN_NODES \
	--max-nodes $PROD_MAX_NODES \
	--enable-autoscaling \
	--enable-cloud-logging \
	--enable-cloud-monitoring \
	--no-enable-basic-auth
