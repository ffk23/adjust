# adjust
## Prerequisite
Minikube and Docker client are installed. Docker daemon is configure dto use local Minikube daemon
https://minikube.sigs.k8s.io/docs/commands/docker-env/
## Build Docker image
Run the following command in prohect root
docker build . --file Dockerfile --tag adjust-http_server:latest
## Deploy using helm
helm install --generate-name --set global.env=test --set app.image="adjust-http_server:latest" --create-namespace --namespace test .helm
## Check your app through LB
The application is exposed throuch service type LoadBalancer.
You need to use minikube tunnel to get access to your service
Please check https://minikube.sigs.k8s.io/docs/handbook/accessing/
