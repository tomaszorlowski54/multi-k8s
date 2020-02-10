#!/bin/bash
docker build -t torlowski/multi-client:latest -t torlowski/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t torlowski/multi-server:latest -t torlowski/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t torlowski/multi-worker:latest -t torlowski/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push torlowski/multi-client:latest 
docker push torlowski/multi-server:latest 
docker push torlowski/multi-worker:latest
docker push torlowski/multi-client:$SHA 
docker push torlowski/multi-server:$SHA 
docker push torlowski/multi-worker:$SHA 
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=torlowski/multi-server:$SHA
kubectl set image deployments/client-deployment server=torlowski/multi-client:$SHA
kubectl set image deployments/worker-deployment server=torlowski/multi-worker:$SHA