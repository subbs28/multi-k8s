docker build -t subbs28/multi-client:latest -t subbs28:multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t subbs28/multi-server:latest -t subbs28/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t subbs28/multi-worker:latest -t subbs28/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push subbs28/multi-client:latest
docker push subbs28/multi-server:latest
docker push subbs28/multi-worker:latest

docker push subbs28/multi-client:$SHA
docker push subbs28/multi-server:$SHA
docker push subbs28/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=subbs28/multi-server:$SHA
kubectl set image deployment/client-deployment client=subbs28/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=subbs28/multi-worker:$SHA
