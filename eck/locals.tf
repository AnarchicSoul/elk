locals {
  values_config = <<-EOT
eck-elasticsearch:
  enabled: true
  fullnameOverride: elasticsearch
  nodeSets:
  - name: default
    count: 1
    config:
      node.store.allow_mmap: false
    volumeClaimTemplates:
    - metadata:
        name: elasticsearch-data
      spec:
        accessModes:
        - ReadWriteOnce
        resources:
          requests:
            storage: 20Gi
    ${var.docker-desktop ? var.hostAliases : ""}
        containers:
        - name: elasticsearch
          env:
            - name: KIBANA_URL
              value: "https://kibana-kb-http.${var.namespace}.svc.cluster.local"

eck-kibana:
  enabled: true
  fullnameOverride: kibana
  spec:
    elasticsearchRef:
      name: elasticsearch
    config:
      server.publicBaseUrl: "https://${var.kibana_ingress}"
    ${var.docker-desktop ? var.hostAliases : ""}
  EOT
}
