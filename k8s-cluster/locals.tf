locals {
  getlicence = <<-EOT
    apiVersion: v1
    kind: Secret
    metadata:
      name: eck-trial-license
      namespace: ${var.namespace}  
      labels:
        license.k8s.elastic.co/type: enterprise_trial
      annotations:
        elastic.co/eula: accepted 
    EOT
}
