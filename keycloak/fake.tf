locals {
  client_fake = jsonencode(
    {
      "clientId": "kibana",
      "name": "Fake Client for Kibana",
      "description": "Client for Kibana OIDC integration",
      "rootUrl": "https://${var.kibana_ingress}",
      "adminUrl": "https://${var.kibana_ingress}",
      "baseUrl": "https://${var.kibana_ingress}",
      "surrogateAuthRequired": false,
      "enabled": true,
      "alwaysDisplayInConsole": false,
      "clientAuthenticatorType": "client-secret",
      "secret": "z4Ux09d1GrR5GVUMleJVSPwYkDFdiaxZ",
      "redirectUris": [
        "https://${var.kibana_ingress}/*"
      ],
      "webOrigins": [
        "https://${var.kibana_ingress}"
      ],
      "notBefore": 0,
      "bearerOnly": false,
      "consentRequired": false,
      "standardFlowEnabled": true,
      "implicitFlowEnabled": false,
      "directAccessGrantsEnabled": true,
      "serviceAccountsEnabled": true,
      "authorizationServicesEnabled": true,
      "publicClient": false,
      "frontchannelLogout": true,
      "protocol": "openid-connect",
      "attributes": {
        "oidc.ciba.grant.enabled": "false",
        "client.secret.creation.time": "1719221050",
        "backchannel.logout.session.required": "true",
        "post.logout.redirect.uris": "https://${var.kibana_ingress}/*",
        "display.on.consent.screen": "false",
        "oauth2.device.authorization.grant.enabled": "false",
        "backchannel.logout.revoke.offline.tokens": "false"
      },
      "authenticationFlowBindingOverrides": {},
      "fullScopeAllowed": true,
      "nodeReRegistrationTimeout": -1,
      "protocolMappers": [
        {
          "name": "aud-mapper",
          "protocol": "openid-connect",
          "protocolMapper": "oidc-audience-mapper",
          "consentRequired": false,
          "config": {
            "included.client.audience": "kibana",
            "id.token.claim": "true",
            "access.token.claim": "true",
            "userinfo.token.claim": "true"
          }
        },
        {
          "name": "Groups",
          "protocol": "openid-connect",
          "protocolMapper": "oidc-group-membership-mapper",
          "consentRequired": false,
          "config": {
            "id.token.claim": "true",
            "access.token.claim": "true",
            "claim.name": "groups",
            "multivalued": "true",
            "userinfo.token.claim": "true"
          }
        }
      ],
      "defaultClientScopes": [
        "roles",
        "profile",
        "email"
      ],
      "optionalClientScopes": [
        "address",
        "phone",
        "offline_access"
      ],
      "access": {
        "view": true,
        "configure": true,
        "manage": true
      }
    }
  )
}
