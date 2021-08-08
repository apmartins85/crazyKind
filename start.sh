#!/bin/bash
echo "We suppose that you already have docker installed, Am I right?"
open -a Docker
sleep 20
echo "Creating kind cluster (we also suppose that you already have kind installed) =)"
kind create cluster --name kind
echo "Checking kind cluster:"
kind get clusters
sleep 5
kubectl cluster-info --context kind-kind
sleep 5
kubectl get nodes
sleep 5
echo "Well done, for now, We will destroy everything!! 👿"
kind delete cluster --name kind
osascript -e 'quit app "Docker"'
