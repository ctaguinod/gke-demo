## gke-demo

### 1. [gke-gcloud](gke-gcloud/)

1. Provision 3 GCP Projects.  
   `$(USER)-shared` - Use this Project to host Source Repositories and Container Registry    
   `$(USER)-dev`  
   `$(USER)-prod`  
2. Provision 3 GKE Clusters on each Project.  
   `shared`- Deploy Spinnaker to this GKE Cluster   
   `dev`  
   `prod`  

### 2. [Bookinfo](bookinfo/)
This sample app is copied from [Istio Samples](https://github.com/istio/istio/tree/master/samples/bookinfo/src) 
This guide will do the following:
1. Create Git repositories for the bookinfo sample app in [Google Source Repositories](https://cloud.google.com/source-repositories/)
2. Commit the Bookinfo app to the created repository. 
3. Create [Build Triggers](https://cloud.google.com/container-builder/) to automatically Build Containers Images.
4. Upload Container Images to [Container Registry](https://cloud.google.com/container-registry/)

### 3. [helloworld](helloworld/).
This guide will do the following:
1. Create Git repositories for the helloworld sample app in [Google Source Repositories](https://cloud.google.com/source-repositories/)
2. Commit the helloworld app to the created repository. 
3. Create [Build Triggers](https://cloud.google.com/container-builder/) to automatically Build Containers Images.
4. Upload Container Images to [Container Registry](https://cloud.google.com/container-registry/)

### 4. [Istio](istio/)

1. Deploy Istio to GKE Dev cluster.  
2. Deploy Bookinfo to Istio enabled GKE Dev cluster.  


### 5. [Spinnaker](spinnaker/)

1. Provision Compute Engine Instance to use for Halyard.  
2. Deploy Spinnaker to the GKE Shared cluster.  
3. Create Spinnaker Pipelines.
