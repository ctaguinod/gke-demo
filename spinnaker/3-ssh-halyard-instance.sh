#!/bin/bash
. set-vars.sh

gcloud config set project $SHARED_PROJECT_ID

gcloud compute ssh $HALYARD_HOST \
	--project=$SHARED_PROJECT_ID \
	--zone=$HALYARD_ZONE \
	--ssh-flag="-L 9000:localhost:9000" \
	--ssh-flag="-L 8084:localhost:8084"

