#######################################################################################
## Base Config
#######################################################################################
# Careful if you modify this part, be sure to know your cluster. 
# Base component can be disabled from install, but be sure they exists ! 


## Common config
locals {
    mydomain    = "${yamldecode(file("config.yaml")).baseconfig.common.mydomain}"
    ingressip = "${yamldecode(file("config.yaml")).baseconfig.common.ingressip}"
    hostAliases = <<EOT
podTemplate:
      spec:
        hostAliases:
        - ip: "${local.ingressip}"
          hostnames:
          - "${local.kibana_ingress}"
          - "${local.elastic_ingress}"
          - "${local.keycloak_ingress}"
EOT
}
variable "docker-desktop" {
    description = "enable = true & disable = false"
    type        = bool
    default     = true
} 

## Kubernetes config 
variable "certmgr" {
    description = "enable = true & disable = false"
    type        = bool
    default     = true
} 
variable "nginxoss" {
    description = "enable = true & disable = false"
    type        = bool
    default     = true
} 
locals {
    namespace    = "${yamldecode(file("config.yaml")).baseconfig.kubernetes.namespace}"
}


## Keycloak Config
variable "keycloak" {
    description = "enable = true & disable = false"
    type        = bool
    default     = true
} 
variable "keycloak_password" {
    description = "Type keycloak password"
    type        = string
    sensitive   = true
    # remove default if you want secure password 
    # default     = "admin"
}  
variable "superadmin" {
    description = "Type keycloak superadmin password who will access all applications"
    type        = string
    sensitive   = true
    # remove default if you want secure password 
    # default     = "superadmin"
}  
locals {
    keycloak_host = "${yamldecode(file("config.yaml")).baseconfig.keycloak.keycloak_host}"
    keycloak_ingress = "${local.keycloak_host}.${local.mydomain}"
}


## ECK Config
variable "eck" {
    description = "enable = true & disable = false"
    type        = bool
    default     = true
} 
variable "eck_password" {
    description = "Type keycloak password"
    type        = string
    sensitive   = true
    # remove default if you want secure password 
    # default     = "admin"
}  
locals {
    elastic_host = "${yamldecode(file("config.yaml")).baseconfig.eck.elastic_host}"
    elastic_ingress = "${local.elastic_host}.${local.mydomain}"
    kibana_host = "${yamldecode(file("config.yaml")).baseconfig.eck.kibana_host}"
    kibana_ingress = "${local.kibana_host}.${local.mydomain}"
}