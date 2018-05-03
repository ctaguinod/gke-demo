#!/bin/bash
. set-vars.sh

gcloud config set project $PROJECT_ID

# Set Git username / email
git config --global user.email "$EMAIL_ADDRESS"
git config --global user.name "$USERNAME"

cd bookinfo-details
git tag $TAG
git push --tags
cd ../

cd bookinfo-productpage
git tag $TAG
git push --tags
cd ../

cd bookinfo-ratings
git tag $TAG
git push --tags
cd ../

cd bookinfo-reviews
git tag $TAG
git push --tags
cd ../
