docker build -t max13j/multi-client:latest -t max13j/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t max13j/multi-server:latest -t max13j/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t max13j/multi-worker:latest -t max13j/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push max13j/multi-client:latest
docker push max13j/multi-server:latest
docker push max13j/multi-worker:latest

docker push max13j/multi-client:$SHA
docker push max13j/multi-server:$SHA
docker push max13j/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=max13j/multi-server:$SHA
kubectl set image deployments/client-deployment client=max13j/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=max13j/multi-worker:$SHA