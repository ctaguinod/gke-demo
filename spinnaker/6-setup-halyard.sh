#!/bin/bash
. set-vars.sh

# Generate key for the spinnaker iam service account
gcloud iam service-accounts keys create $SPINNAKER_SA_DEST \
	--iam-account $SPINNAKER_SA_EMAIL

# Set up to persist to GCS
hal config storage gcs edit \
	--project $SHARED_PROJECT_ID \
	--bucket-location $SPINNAKER_BUCKET_LOCATION \
	--json-path $SPINNAKER_SA_DEST

# Set up pulling from GCR
hal config provider docker-registry enable
hal config provider docker-registry account add gcr-shared \
	--password-file $SPINNAKER_SA_DEST \
	--username _json_key \
	--address gcr.io \
	--repositories ctaguinod-shared/bookinfo-details \
	ctaguinod-shared/bookinfo-productpage \
	ctaguinod-shared/bookinfo-ratings \
	ctaguinod-shared/bookinfo-reviews \
	ctaguinod-shared/sample-app \
	ctaguinod-shared/helloworld

# Set up the Kubernetes provider
hal config provider kubernetes enable

# Dev Cluster
DEV_CONTEXT=`kubectl config get-contexts | grep $DEV_CLUSTER_NAME | awk '{print $2;}'`
kubectl config use-context $DEV_CONTEXT
hal config provider kubernetes account add k8s-dev \
    --context $DEV_CONTEXT \
    --docker-registries gcr-shared 

# Prod Cluster
PROD_CONTEXT=`kubectl config get-contexts | grep $PROD_CLUSTER_NAME | awk '{print $2;}'`
kubectl config use-context $PROD_CONTEXT
hal config provider kubernetes account add k8s-prod \
    --context $PROD_CONTEXT \
    --docker-registries gcr-shared

# Shared Cluster
SHARED_CONTEXT=`kubectl config get-contexts | grep $SHARED_CLUSTER_NAME | awk '{print $2;}'`
kubectl config use-context $SHARED_CONTEXT
hal config provider kubernetes account add k8s-shared \
	--context $SHARED_CONTEXT \
	--docker-registries gcr-shared

# Enable the pipeline templates:
hal config features edit \
	--pipeline-templates true

mkdir -p ~/.hal/default/profile/
cat > ~/.hal/default/profile/orca-local.yml <<EOF
pipelineTemplates:
  enabled: true
  jinja:
    enabled: true
EOF

# Enable oAuth authentication:
hal config security authn oauth2 edit --provider google \
  --client-id $CLIENT_ID \
  --client-secret $CLIENT_SECRET \
  --user-info-requirements hd=$OAUTH_ALLOWED_DOMAIN
hal config security authn oauth2 enable

# Configure Static IPs 
sed -i -e "s/SPINNAKERUI/$SPINNAKERUI/g" spinnaker-services.yaml
sed -i -e "s/SPINNAKERAPI/$SPINNAKERAPI/g" spinnaker-services.yaml

# Create spinnaker namespace
kubectl create namespace spinnaker

# Create services / load balancer
kubectl create -f spinnaker-services.yaml

# Update Spinnaker URL
hal config security ui edit \
    --override-base-url http://spinnaker.$SPINNAKER_DOMAIN_URL

hal config security api edit \
    --override-base-url http://spinnaker-api.$SPINNAKER_DOMAIN_URL

# Set Version
hal config version edit --version 1.6.1

# Deploy
hal config deploy edit --type distributed --account-name k8s-shared

hal deploy apply

