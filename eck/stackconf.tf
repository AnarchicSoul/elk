resource "kubernetes_manifest" "stackconf" {
  depends_on = [kubernetes_secret.example]
  manifest = yamldecode(<<-EOF
    apiVersion: stackconfigpolicy.k8s.elastic.co/v1alpha1
    kind: StackConfigPolicy
    metadata:
      name: test-stack-config-policy
      namespace: ${var.namespace} 
    spec:
      resourceSelector:
        matchLabels:
          app.kubernetes.io/instance: eck-stack
          app.kubernetes.io/managed-by: Helm
      elasticsearch:
        secureSettings:
          - secretName: oidc-client-secret
        securityRoleMappings:
          oidc_kibana:
            roles: [ "superuser" ]
            rules:
              all:
                - field: { realm.name: "*" }
            enabled: true
        config:
          logger.org.elasticsearch.discovery: DEBUG
          xpack:
            security:
              authc:
                token.enabled: true
                realms:
                  oidc:
                    realm1:
                      order: 2
                      rp.client_id: "kibana"
                      rp.response_type: "code"
                      rp.redirect_uri: "https://${var.kibana_ingress}/api/security/oidc/callback"
                      op.issuer: "https://${var.keycloak_ingress}/realms/realm1"
                      op.authorization_endpoint: "https://${var.keycloak_ingress}/realms/realm1/protocol/openid-connect/auth"
                      op.token_endpoint: "https://${var.keycloak_ingress}/realms/realm1/protocol/openid-connect/token"
                      op.userinfo_endpoint: "https://${var.keycloak_ingress}/realms/realm1/protocol/openid-connect/userinfo"
                      op.jwkset_path: "https://${var.keycloak_ingress}/realms/realm1/protocol/openid-connect/certs"
                      op.endsession_endpoint: "https://${var.keycloak_ingress}/realms/realm1/protocol/openid-connect/logout"
                      rp.post_logout_redirect_uri: "https://${var.kibana_ingress}/logged_out"
                      claims.principal: name
                      ssl.verification_mode: none
      kibana:
        config:
          xpack.security.authc.providers:
            oidc.realm1:
              order: 0
              realm: realm1
              description: "Log in with KC"
            basic.basic1:
              order: 1
    EOF
  )
}
