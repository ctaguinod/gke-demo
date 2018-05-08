## spinnaker

This is a quick guide to do a Spinnaker demo.  

References:  
1. [Halyard on GKE Quickstart](https://www.spinnaker.io/setup/quickstart/halyard-gke/)
2. [Creating public Spinnaker endpoints](https://www.spinnaker.io/setup/quickstart/halyard-gke-public/#part-2-creating-public-spinnaker-endpoints)

### Usage

**1. Clone this repo.**  
```
git clone https://github.com/ctaguinod/gke-demo/
cd gke-demo/spinnaker/
```

**2. Modify the variables configured in the file `set-vars.sh`.**  

**3. Provision Halyard Instance.**  
```
chmod +x 1-provision-halyard-instance.sh
./1-provision-halyard-instance.sh
```

**4. [Configure Public Endpoint](https://www.spinnaker.io/setup/quickstart/halyard-gke-public/#part-2-creating-public-spinnaker-endpoints)**  
1. [Create oAuth Credential](https://www.spinnaker.io/setup/quickstart/halyard-gke-public/#part-1-configuring-authentication)  
2. [Reserve 2 static IPs, Create DNS records and Configure oAuth](https://www.spinnaker.io/setup/quickstart/halyard-gke-public/#part-2-creating-public-spinnaker-endpoints)  
3. Update `set-vars.sh` to include oAuth credentials and Static IPs.  
4. Create DNS record for `spinnaker.$SPINNAKER_DOMAIN_URL` and `spinnaker-api.$SPINNAKER_DOMAIN_URL`  

**5. SSH to the Halyard Instance and Clone this repo again inside the instance.**
```
chmod +x 3-ssh-halyard-instance.sh
./3-ssh-halyard-instance.sh
```
Clone this repo.  
```
git clone https://github.com/ctaguinod/gke-demo/
cd spinnaker/
```

**6. Setup kubectl Credentials**
```
chmod +x 4-setup-kubectl-creds.sh
./4-setup-kubectl-creds.sh
```

**7. Install Halyard**
```
chmod +x 5-install-halyard.sh
./5-install-halyard.sh
```

**8. Configure Halyard and Deploy Spinnaker**
```
chmod +x 6-setup-halyard.sh
./6-setup-halyard.sh
```

**9. Access Spinnkaer UI - `http://spinnaker.$SPINNAKER_DOMAIN_URL`**
Login using your email from the oAuth Configured domain in the variable `OAUTH_ALLOWED_DOMAIN`  


**10. Create `helloworld` test Pipeline**  
1. Click **Actions** > **Create Application**  
   Name: `helloworld`  
   Owner Email: `your@email.address`  
2. Click **Create**   
3. Go to `Applications` > `helloworld` > Click `Pipelines` > `Create`  
   Type: pipeline  
   Pipeline Name: `helloworld test pipeline`
4. Click **Create**   
5. Click **Configure** > **Pipeline Actions** > **Edit as JSON**
6. Copy test pipeline from [pipeline/helloworld-pipeline-json.txt](pipeline/helloworld-pipeline-json.txt) and Paste the pipeline.
7. Click **Update Pipeline**

