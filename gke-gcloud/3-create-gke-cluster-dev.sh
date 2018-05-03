#!/bin/bash
. set-vars.sh

gcloud config set project $DEV_PROJECT_ID
gcloud services enable iam.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com
gcloud iam service-accounts create $DEV_GKE_SA --project $DEV_PROJECT_ID --display-name $DEV_GKE_SA
gcloud projects add-iam-policy-binding $DEV_PROJECT_ID --member serviceAccount:$DEV_GKE_SA_EMAIL --role roles/storage.admin
gcloud projects add-iam-policy-binding $DEV_PROJECT_ID --member serviceAccount:$DEV_GKE_SA_EMAIL --role roles/logging.logWriter
gcloud projects add-iam-policy-binding $DEV_PROJECT_ID --member serviceAccount:$DEV_GKE_SA_EMAIL --role roles/monitoring.metricWriter
gcloud projects add-iam-policy-binding $DEV_PROJECT_ID --member serviceAccount:$DEV_GKE_SA_EMAIL --role roles/container.admin
# ACCESS TO SHARED CLUSTERS GCR
gcloud projects add-iam-policy-binding $SHARED_PROJECT_ID --member serviceAccount:$DEV_GKE_SA_EMAIL --role roles/storage.objectViewer
gcloud container clusters create $DEV_CLUSTER_NAME \
	--project $DEV_PROJECT_ID \
	--network "default" \
	--subnetwork "default" \
	--machine-type $DEV_MACHINE_TYPE \
	--zone $DEV_ZONE \
	--additional-zones $DEV_ZONE2 \
	--cluster-version=$DEV_CLUSTER_VERSION \
	--image-type="COS" \
	--disk-size $DEV_DISK_SIZE \
	--service-account $DEV_GKE_SA_EMAIL \
	--num-nodes $DEV_NUM_NODES \
	--min-nodes $DEV_MIN_NODES \
	--max-nodes $DEV_MAX_NODES \
	--enable-autoscaling \
	--enable-cloud-logging \
	--enable-cloud-monitoring \
	--no-enable-basic-auth
