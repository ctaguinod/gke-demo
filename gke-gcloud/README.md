## gke-gcloud

This creates GCP Projects and GKE Cluseters using [gcloud](https://cloud.google.com/sdk/) cli.

### Usage

**1. Clone this repo.**
```
git clone https://github.com/ctaguinod/gke-demo/
cd gke-demo/gke-gcloud/
```

**2. Modify the variables configured in the file `set-vars.sh`.**
The default variables will craete 3 GCP Projects and 3 GKE Clusters: `shared` `prod` `dev`

**3. Create GCP Projects.**
```
chmod +x 1-create-gcp-projects.sh
./1-create-gcp-projects.sh
```

**4. Create GKE `Shared` Cluster.**
```
chmod +x 2-create-gke-cluster-shared.sh
./2-create-gke-cluster-shared.sh
```

**5. Create GKE `Dev` Cluster.**
```
chmod +x 3-create-gke-cluster-dev.sh
./3-create-gke-cluster-dev.sh
```

**6. Create GKE `Prod` Cluster.**
```
chmod +x 4-create-gke-cluster-prod.sh
./4-create-gke-cluster-prod.sh
```

**7. Get GKE Credentials.**
```
chmod +x 5-get-creds.sh
./5-get-creds.sh
```

**7. Test by getting all nodes with `kubectl get nodes` for each GKE Cluster.**
```
chmod +x 6-get-gke-nodes.sh
./6-get-gke-nodes.sh
```
