#! /bin/bash

sed "s/tagVersion/$1/g" wordpress-deployment.yml > wordpress-config.k8s.yaml