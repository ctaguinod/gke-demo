## Bookinfo 

This guide will do the following:
1. Create Git repositories for the helloworld sample app in [Google Source Repositories](https://cloud.google.com/source-repositories/)
2. Commit the helloworld app to the created repository. 
3. Create [Build Triggers](https://cloud.google.com/container-builder/) to automatically Build Containers Images.
4. Upload Container Images to [Container Registry](https://cloud.google.com/container-registry/)

### Usage

**1. Clone this repo.**
```
git clone https://github.com/ctaguinod/gke-demo/
cd gke-demo/helloworld/
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

This script creates a `helloworld` Private Git Repository in Google Source Repositories and pushes the helloworld test code.
```
cd helloworld
git init
git add .
git commit -m "Initial commit"
gcloud source repos create helloworld
git config credential.helper gcloud.sh
git remote add origin https://source.developers.google.com/p/$PROJECT_ID/r/helloworld
git push origin master
cd ../
```

**4. Create Build Triggers.**
1. In the GCP Console, click **Build Triggers** in the Container Registry section.
2. Select **Cloud Source Repository** and click **Continue**.
3. Select your newly created helloworld repository from the list, and click **Continue**.
4. Set the following trigger settings  
   Name: `helloworld-tags`  
   Trigger type: `Tag`  
   Tag (regex): `v.*`  
   Build configuration: `cloudbuild.yaml`  
   cloudbuild.yaml location: `/cloudbuild.yaml`  
   Click **Create Trigger**.  
5. From now on, whenever you push a Git tag prefixed with the letter **"v"** to your source code repository, Container Builder automatically builds and pushes your application as a Docker image to Container Registry.

**5. Create Tags and commit to trigger Build.**
```
chmod +x 3-create-tags.sh
./3-create-tags.sh
cd ..
```
Creates a Git Tag and push change to Container Registry
```
cd helloworld
git tag v1.0.0
git push --tags
cd ../
```

In **Container Registry**, click **Build History** to check that the build has been triggered. If not, verify the trigger was configured properly in the previous section.
