resource "kubernetes_secret" "example" {
  metadata {
    name = "elasticsearch-es-elastic-user"
    namespace  = var.namespace
  }
  data = {
    elastic = "${var.password}"
  }
}

resource "kubernetes_secret" "clientsecret" {
  metadata {
    name = "oidc-client-secret"
    namespace  = var.namespace
  }
  data = {
    "xpack.security.authc.realms.oidc.realm1.rp.client_secret" = "z4Ux09d1GrR5GVUMleJVSPwYkDFdiaxZ"
  }
}

resource "kubernetes_ingress_v1" "kibana" {
  depends_on = [helm_release.eck-stack]
  wait_for_load_balancer = true
  metadata {
    name      = "kibana"
    namespace  = var.namespace
    annotations = {
      "nginx.ingress.kubernetes.io/backend-protocol" = "HTTPS"
    }
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = "kibana.localhost"
      http {
        path {
          path = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "kibana-kb-http"
              port {
                number = 5601
              }
            }
          }
        }
      }
    }
    tls {
      secret_name = "wildcard-cert"
      hosts = ["kibana.localhost"]
    }
  }
}


resource "kubernetes_ingress_v1" "elastic" {
  depends_on = [helm_release.eck-stack]
  wait_for_load_balancer = true
  metadata {
    name      = "elasticsearch"
    namespace  = var.namespace
    annotations = {
      "nginx.ingress.kubernetes.io/backend-protocol" = "HTTPS"
    }
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = "elastic.localhost"
      http {
        path {
          path = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "elasticsearch-es-http"
              port {
                number = 9200
              }
            }
          }
        }
      }
    }
    tls {
      secret_name = "wildcard-cert"
      hosts = ["kibana.localhost"]
    }
  }
}