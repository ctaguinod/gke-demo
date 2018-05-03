## istio-demo

This is a quick guide to do a demo based on the Istio official docs:
1. [Istio Offical Docs](https://istio.io/docs/) 
2. [Quick Start with Google Kubernetes Engine](https://istio.io/docs/setup/kubernetes/quick-start-gke-dm.html)
3. [Traffic Management](https://istio.io/docs/tasks/traffic-management/)

### Usage

**1. Clone this repo.**

```
git clone https://github.com/ctaguinod/gke-demo/
cd istio/
```

**2. Modify the variables configured in the file `set-vars.sh`.**  
Default variables: 
```
CLUSTER_NAME=dev
PROJECT_ID=$USER-$CLUSTER_NAME
ISTIO_VERSION=0.7.1
```

**3. Install Istio and addons to GKE Cluster.**  
```
chmod +x 1-install-istio.sh
./1-install-istio.sh
```

**4. Install Bookinfo App.**
```
chmod +x 2-install-bookinfo.sh
./2-install-bookinfo.sh
```

**5. Port forward Addons: Zipkin, Grafana, Dotviz and Prometheus.**  
```
chmod +x 3-port-forward-addons.sh
./3-port-forward-addons.sh
```

Use Cloud Shells [Web Preview](https://cloud.google.com/shell/docs/using-web-preview) to access the following: 

```
Zipkin URL/Port: http://localhost:9411
Grafana URL/Port: http://localhost:3000
Dotviz URL/Port: http://localhost:8088/dotviz
Prometheus URL/Port: http://localhost:9090/graph
```

