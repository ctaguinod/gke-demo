## istio-demo

This is a quick guide to do a demo based on the Istio official docs:
1. [Istio Offical Docs](https://istio.io/docs/) 
2. [Quick Start with Google Kubernetes Engine](https://istio.io/docs/setup/kubernetes/quick-start-gke-dm.html)

### Usage

**1. Clone this repo.**

```
git clone https://github.com/ctaguinod/gke-demo/
cd istio/
```

**2. Modify the variables configured in the file `set-vars.sh`.**  
Default variables: 
```
# GKE Cluster and GCP Project to Install Istio
CLUSTER_NAME=dev
PROJECT_ID=$USER-$CLUSTER_NAME
# GCP Project with Container Registry
SHARED_CLUSTER_NAME=shared
SHARED_PROJECT_ID=$USER-$SHARED_CLUSTER_NAME
# LATEST RELEASE: https://github.com/istio/istio/releases
ISTIO_VERSION=0.7.1
```

**3. Deploy Istio.**  
```
chmod +x 1-deploy-istio.sh
./1-deploy-istio.sh
```

**4. Deploy Observability addons.**  
```
chmod +x 2-deploy-observability-addons.sh
./2-deploy-observability-addons.sh
```

**5. Deploy Bookinfo App.**
```
chmod +x 3-deploy-bookinfo.sh
./3-deploy-bookinfo.sh
```
To get Bookinfo URL
```
chmod +x get-bookinfo-url.sh
./get-bookinfo-url.sh
```

**6. Port forward Addons: Zipkin, Grafana, Dotviz and Prometheus.**  
```
chmod +x 4-port-forward-addons.sh
./4-port-forward-addons.sh
```

Use Cloud Shell [Web Preview](https://cloud.google.com/shell/docs/using-web-preview) to access the following: 

```
Zipkin URL/Port: http://localhost:9411
Grafana URL/Port: http://localhost:3000
Dotviz URL/Port: http://localhost:8088/dotviz
Prometheus URL/Port: http://localhost:9090/graph
```

**7. [Configure Request Routing](https://istio.io/docs/tasks/traffic-management/request-routing.html).**

```
. set-vars.sh
gcloud config set project $PROJECT_ID
CONTEXT=`kubectl config get-contexts | grep $CLUSTER_NAME | awk '{print $2;}'`
kubectl config use-context $CONTEXT
export PATH=$PWD/istio-$ISTIO_VERSION/bin:$PATH
```

`istioctl create -f istio-$ISTIO_VERSION/samples/bookinfo/kube/route-rule-all-v1.yaml` - *This will route all traffic to bookinfo V1. Refresh the page couple of times to verify all traffic is routed to V1.*  

`istioctl create -f istio-$ISTIO_VERSION/samples/bookinfo/kube/route-rule-reviews-test-v2.yaml` - *This will route user `jason` to bookinfo V2. Login as user `jason` and traffic should be routed to V2.*  

`istioctl get routerules` - *List router rules*  

`istioctl delete -f istio-$ISTIO_VERSION/samples/bookinfo/kube/route-rule-all-v1.yaml` - *Delete router rule*  

`istioctl delete -f istio-$ISTIO_VERSION/samples/bookinfo/kube/route-rule-reviews-test-v2.yaml` - *Delete router rule*  

You can test other capabilities of Istio by following guides here: https://istio.io/docs/tasks/traffic-management/

**8. Explore Zipkin, Grafana, Service Graph and Prometheus.** - *It should now provide details on whats happening on bookinfo.*

