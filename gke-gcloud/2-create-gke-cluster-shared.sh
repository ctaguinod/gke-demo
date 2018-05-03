#!/bin/bash
. set-vars.sh

gcloud config set project $SHARED_PROJECT_ID
gcloud services enable sourcerepo.googleapis.com
gcloud services enable cloudbuild.googleapis.com
gcloud services enable iam.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com
gcloud iam service-accounts create $SHARED_GKE_SA --project $SHARED_PROJECT_ID --display-name $SHARED_GKE_SA
gcloud projects add-iam-policy-binding $SHARED_PROJECT_ID --member serviceAccount:$SHARED_GKE_SA_EMAIL --role roles/storage.admin
gcloud projects add-iam-policy-binding $SHARED_PROJECT_ID --member serviceAccount:$SHARED_GKE_SA_EMAIL --role roles/logging.logWriter
gcloud projects add-iam-policy-binding $SHARED_PROJECT_ID --member serviceAccount:$SHARED_GKE_SA_EMAIL --role roles/monitoring.metricWriter
gcloud projects add-iam-policy-binding $SHARED_PROJECT_ID --member serviceAccount:$SHARED_GKE_SA_EMAIL --role roles/container.admin
gcloud container clusters create $SHARED_CLUSTER_NAME \
	--project $SHARED_PROJECT_ID \
	--network "default" \
	--subnetwork "default" \
	--machine-type $SHARED_MACHINE_TYPE \
	--zone $SHARED_ZONE \
	--additional-zones $SHARED_ZONE2 \
	--cluster-version=$SHARED_CLUSTER_VERSION \
	--image-type="COS" \
	--disk-size $SHARED_DISK_SIZE \
	--service-account $SHARED_GKE_SA_EMAIL \
	--num-nodes $SHARED_NUM_NODES \
	--min-nodes $SHARED_MIN_NODES \
	--max-nodes $SHARED_MAX_NODES \
	--enable-autoscaling \
	--enable-cloud-logging \
	--enable-cloud-monitoring \
	--no-enable-basic-auth
