#!/bin/bash

namespaces=$(kubectl get hpa --no-headers --all-namespaces | cut -d' ' -f1 | uniq)
do
echo "$namespaces"

kubectl patch hpa  -p '{"spec":{"minReplicas": 1,"maxReplicas":1}}' --all-namespaces
done
