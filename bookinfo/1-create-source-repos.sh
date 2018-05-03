#!/bin/bash
. set-vars.sh

gcloud config set project $PROJECT_ID

# Set Git username / email
git config --global user.email "$EMAIL_ADDRESS"
git config --global user.name "$USERNAME"

cd bookinfo-details
git init
git add .
git commit -m "Initial commit"
gcloud source repos create bookinfo-details
git config credential.helper gcloud.sh
git remote add origin https://source.developers.google.com/p/$PROJECT_ID/r/bookinfo-details
git push origin master
cd ../

cd bookinfo-productpage
git init
git add .
git commit -m "Initial commit"
gcloud source repos create bookinfo-productpage
git config credential.helper gcloud.sh
git remote add origin https://source.developers.google.com/p/$PROJECT_ID/r/bookinfo-productpage
git push origin master
cd ../

cd bookinfo-ratings
git init
git add .
git commit -m "Initial commit"
gcloud source repos create bookinfo-ratings
git config credential.helper gcloud.sh
git remote add origin https://source.developers.google.com/p/$PROJECT_ID/r/bookinfo-ratings
git push origin master
cd ../

cd bookinfo-reviews
git init
git add .
git commit -m "Initial commit"
gcloud source repos create bookinfo-reviews
git config credential.helper gcloud.sh
git remote add origin https://source.developers.google.com/p/$PROJECT_ID/r/bookinfo-reviews
git push origin master
cd ../
