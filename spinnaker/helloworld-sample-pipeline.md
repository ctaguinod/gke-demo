## Helloworld sample pipeline



1. Access Spinnaker UI: http://spinnaker.$SPINNAKER_DOMAIN_URL
2. Create Application
   Name: helloworld
3. Create Pipeline
   Type: Pipeline
   Pipeline Name: Deploy Helloworld to Dev then Prod
   Create from Pipeline
   click Create
4. Pipeline Actions > Edit as JSON
   Copy sample pipeline text from https://raw.githubusercontent.com/ctaguinod/gke-demo/master/spinnaker/pipeline/helloworld-pipeline-json.txt
   Update Pipeline
5. Save Changes.
6. Create Helloworld LoadBalancers
```
chmod +x create-helloworld-loadbalancers.sh
./create-helloworld-loadbalancers.sh
```
7. Modify main.go in helloworld code.
8. Push Code to helloworld repo with tag.
9. Cloud Builder builds Container Image.
10. Spinnaker pulls image
11. Deploys to Dev Cluster.
12. Manual Approval needed.
13. Deploys to Prod Cluster.
