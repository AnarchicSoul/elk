#!/bin/bash

# Terraform login (si nécessaire)
terraform init

# Appliquer la ressource `k8s_cluster` en passant les variables nécessaires
terraform apply -target=module.k8s_cluster -auto-approve \
  -var="eck_password=a" \
  -var="keycloak_password=a" \
  -var="superadmin=a"

# Appliquer les ressources restantes
terraform apply -auto-approve
