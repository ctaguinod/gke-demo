#!/bin/bash
. set-vars.sh

gcloud config set project $PROJECT_ID

# Set Git username / email
git config --global user.email "$EMAIL_ADDRESS"
git config --global user.name "$USERNAME"

cd helloworld
git init
git add .
git commit -m "Initial commit"
gcloud source repos create helloworld
git config credential.helper gcloud.sh
git remote add origin https://source.developers.google.com/p/$PROJECT_ID/r/helloworld
git push origin master
cd ../

