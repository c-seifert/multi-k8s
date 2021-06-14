docker build -t cseifertiz/multi-client:latest -t cseifertiz/multi-client$SHA -f ./client/Dockerfile ./client
docker build -t cseifertiz/multi-server:latest -t cseifertiz/multi-server$SHA -f ./server/Dockerfile ./server
docker build -t cseifertiz/multi-worker:latest -t cseifertiz/multi-worker$SHA -f ./worker/Dockerfile ./worker
docker push cseifertiz/multi-client:latest
docker push cseifertiz/multi-server:latest
docker push cseifertiz/multi-worker:latest
docker push cseifertiz/multi-client:$SHA
docker push cseifertiz/multi-server:$SHA
docker push cseifertiz/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cseifertiz/multi-server:$SHA
kubectl set image deployments/client-deployment client=cseifertiz/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cseifertiz/multi-worker:$SHA