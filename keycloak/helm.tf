#######################################################################################
# HELM INSTALL
#######################################################################################

resource "helm_release" "keycloak" {
  name       = "keycloak"
  namespace  = var.namespace
  chart      = "./keycloak/keycloak-21.4.1.tgz"

  values = [
    "${file("./keycloak/values.yaml")}",
    local.keycloak_config
  ]

  set {
      name  = "auth.adminPassword"
      value = var.password
    }
  set {
      name  = "ingress.hostname"
      value = var.keycloak_ingress
    }
  
} 

locals {
  keycloak_config = <<-EOT
ingress:
  annotations:
    nginx.ingress.kubernetes.io/backend-protocol: HTTPS
    nginx.ingress.kubernetes.io/proxy-ssl-secret: ${var.namespace}/root-ca-svc-secret
  extraTls:
    - secretName: wildcard-cert
      hosts:
        - ${var.keycloak_ingress}
keycloakConfigCli:
  configuration: 
    realm1.json: |
        {
          "realm": "realm1",
          "enabled": true,
          "userManagedAccessAllowed": true,
          "clients": [
            ${local.client_fake}
          ],
          "roles": {
            "client": {
              "kibana": [
                {
                  "name": "kibana",
                  "description": "Role for Kibana users"
                }
              ]
            }
          },
          "users": [
            {
              "username": "admin",
              "enabled": true,
              "emailVerified": true,
              "firstName": "Rootus",
              "lastName": "Adminus",
              "email": "local-admin@mail.com",
              "credentials": [
                {
                  "type": "password",
                  "value": "${var.superadmin}"
                }
              ],
              "clientRoles": {
                "kibana": [
                  "kibana"
                ]
              }
            }
          ]
        }
  EOT
}
