resource "kubernetes_namespace_v1" "example" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_manifest" "licence" {
  depends_on = [kubernetes_namespace_v1.example]
  manifest = yamldecode(local.getlicence) 
}