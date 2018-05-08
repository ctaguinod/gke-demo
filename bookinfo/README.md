## Bookinfo 

This sample app is copied from [Istio Samples](https://github.com/istio/istio/tree/master/samples/bookinfo/src)

This guide will do the following:
1. Create Git repositories for the bookinfo sample app in [Google Source Repositories](https://cloud.google.com/source-repositories/)
2. Commit the Bookinfo app to the created repository. 
3. Create [Build Triggers](https://cloud.google.com/container-builder/) to automatically Build Containers Images.
4. Upload Container Images to [Container Registry](https://cloud.google.com/container-registry/)

### Usage

**1. Clone this repo.**
```
git clone https://github.com/ctaguinod/gke-demo/
cd gke-demo/bookinfo/
```

**2. Modify the variables configured in the file `set-vars.sh`.**
Default variables: 
```
CLUSTER_NAME=shared
PROJECT_ID=$USER-$CLUSTER_NAME
EMAIL_ADDRESS=CHANGE_GIT_EMAIL_ADDRESS
USERNAME=CHANGE_GIT_USERNAME
```

**3. Create Source Repositories.**
```
chmod +x 1-create-source-repos.sh
./1-create-source-repos.sh
```

This script creates a `bookinfo-details`, `bookinfo-productpage, `bookinfo-ratings` and `bookinfo-reviews`` Private Git Repositories in Google Source Repositories and pushes the bookinfo codes.
```
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
```

**4. Create Build Triggers.**
1. In the GCP Console, click **Build Triggers** in the Container Registry section.
2. Select **Cloud Source Repository** and click **Continue**.
3. Select your newly created bookinfo-appname repository from the list, and click **Continue**.
4. Set the following trigger settings  
   Name: `bookinfo-app-name-tags`  
   Trigger type: `Tag`  
   Tag (regex): `v.*`  
   Build configuration: `cloudbuild.yaml`  
   cloudbuild.yaml location: `/cloudbuild.yaml`  
   Click **Create Trigger**.  
5. From now on, whenever you push a Git tag prefixed with the letter **"v"** to your source code repository, Container Builder automatically builds and pushes your application as a Docker image to Container Registry.
6. Do this for all repos: `bookinfo-details`  `bookinfo-productpage`  `bookinfo-ratings`  `bookinfo-reviews`

**5. Create Tags and commit to trigger Build.**
```
chmod +x 3-create-tags.sh
./3-create-tags.sh
cd ..
```
Creates Git Tags and push change to Container Registry
```
cd bookinfo-details
git tag v1.0.0
git push --tags
cd ../

cd bookinfo-productpage
git tag v1.0.0
git push --tags
cd ../

cd bookinfo-ratings
git tag v1.0.0
git push --tags
cd ../

cd bookinfo-reviews
git tag v1.0.0
git push --tags
cd ../
```

In **Container Registry**, click **Build History** to check that the build has been triggered. If not, verify the trigger was configured properly in the previous section.  
