resource "helm_release" "eck-stack" {
  depends_on = [kubernetes_secret.example]
  name       = "eck-stack"
  namespace  = var.namespace
  chart      = "./eck/eck-stack-0.11.0.tgz"
  values = [local.values_config]
} 

