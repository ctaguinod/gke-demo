#!/bin/bash

echo "Follow the instructions below:"
echo "Configure Public Endpoint: https://www.spinnaker.io/setup/quickstart/halyard-gke-public/#part-2-creating-public-spinnaker-endpoints"
echo "1) Create oAuth Credential: https://www.spinnaker.io/setup/quickstart/halyard-gke-public/#part-1-configuring-authentication"
echo "2) Reserve 2 static IPs, Create DNS records and Configure oAuth: https://www.spinnaker.io/setup/quickstart/halyard-gke-public/#part-2-creating-public-spinnaker-endpoints"
echo "3) Update set-vars.sh to include oAuth credentials"
echo "4) Update set-vars.sh to include Static IPs"
echo "5) Create DNS record for the following:"
echo "   spinnaker.$SPINNAKER_DOMAIN_URL = $SPINNAKERUI"
echo "   spinnaker-api.$SPINNAKER_DOMAIN_URL = $SPINNAKERAPI"
