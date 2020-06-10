docker build -t amit2328/multi-client:latest -t amit2328/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t amit2328/multi-server:latest -t amit2328/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t amit2328/multi-worker:latest -t amit2328/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push amit2328/multi-client:latest
docker push amit2328/multi-server:latest
docker push amit2328/multi-worker:latest

docker push amit2328/multi-client:$SHA
docker push amit2328/multi-server:$SHA
docker push amit2328/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=amit2328/multi-server:$SHA
kubectl set image deployments/client-deployment client=amit2328/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=amit2328/multi-worker:$SHA