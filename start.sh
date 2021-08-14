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
echo "It is time to deploy localstack"
echo "We will install using helm3"
echo "We suppose that you already have installed helm3, Am I right? If so, it is show time!"
sleep 5
kubectl create namespace localstack
helm repo add localstack-repo https://helm.localstack.cloud
helm repo update
helm install localstack localstack-repo/localstack --namespace localstack
sleep 5
echo "Checking localstack deploy"
kubectl get pods -n localstack
sleep 5
echo "It is time to deploy crossplane"
echo "We will install using helm3"
echo "We suppose that you already have installed helm3, Am I right? If so, it is show time!"
kubectl create namespace crossplane-system
helm repo add crossplane-master https://charts.crossplane.io/master/
helm repo update
# Kubernetes 1.15 and newer versions
 helm install crossplane --namespace crossplane-system crossplane-master/crossplane
 sleep 10
kubectl get pods -n crossplane-system
sleep 10
kubectl get pods -n localstack
sleep 10
echo "Well done, for now, We will destroy everything!! 👿"
kind delete cluster --name kind
sleep 10
osascript -e 'quit app "Docker"'