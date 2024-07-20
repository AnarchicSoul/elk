#!/bin/bash

terraform destroy -auto-approve \
  -var="eck_password=a" \
  -var="keycloak_password=a" \
  -var="superadmin=a"