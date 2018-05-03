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

**4. Create Build Triggers.**
1. In the GCP Console, click **Build Triggers** in the Container Registry section.
2. Select **Cloud Source Repository** and click **Continue**.
3. Select your newly created bookinfo-app-name repository from the list, and click Continue.
4. Set the following trigger settings  
   Name: `bookinfo-app-name-tags`  
   Trigger type: `Tag`  
   Tag (regex): `v.*`  
   Build configuration: `cloudbuild.yaml`  
   cloudbuild.yaml location: `/cloudbuild.yaml`  
5. Do this for all repos: `bookinfo-details`  `bookinfo-productpage`  `bookinfo-ratings`  `bookinfo-reviews`

**5. Create Tags and commit to trigger Build.**
```
chmod +x 3-create-tags.sh
./3-create-tags.sh
cd ..
```
