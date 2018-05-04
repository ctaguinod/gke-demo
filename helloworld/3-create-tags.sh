#!/bin/bash
. set-vars.sh

gcloud config set project $PROJECT_ID

# Set Git username / email
git config --global user.email "$EMAIL_ADDRESS"
git config --global user.name "$USERNAME"

cd helloworld
git tag $TAG
git push --tags
cd ../
