docker build -t vaibhav09dev/multi-client:latest -t vaibhav09dev/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vaibhav09dev/multi-server:latest -t vaibhav09dev/multi-server:$SHA -f ./client/Dockerfile ./server
docker build -t vaibhav09dev/multi-worker:latest -t vaibhav09dev/multi-worker:$SHA -f ./client/Dockerfile ./worker 

docker push vaibhav09dev/multi-client:latest
docker push vaibhav09dev/multi-server:latest
docker push vaibhav09dev/multi-worker:latest

docker push vaibhav09dev/multi-client:$SHA
docker push vaibhav09dev/multi-server:$SHA
docker push vaibhav09dev/multi-worker:$SHA

kubectl apply -f K8s
kubectl set image deployments/server-deployment server=vaibhav09dev/multi-server:$SHA
kubectl set image deployments/client-deployment client=vaibhav09dev/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vaibhav09dev/multi-worker:$SHA