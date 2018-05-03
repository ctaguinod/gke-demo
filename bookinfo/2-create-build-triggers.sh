#!/bin/bash

echo "1. In the GCP Console, click Build Triggers in the Container Registry section."

echo "2. Select Cloud Source Repository and click Continue."

echo "3. Select your newly created bookinfo-app-name repository from the list, and click Continue."

echo "4. Set the following trigger settings:"
echo "   Name: bookinfo-app-name-tags"
echo "   Trigger type: Tag"
echo "   Tag (regex): v.*"
echo "   Build configuration: cloudbuild.yaml"
echo "   cloudbuild.yaml location: /cloudbuild.yaml"

echo "Do this for all repos: bookinfo-details  bookinfo-productpage  bookinfo-ratings  bookinfo-reviews"
