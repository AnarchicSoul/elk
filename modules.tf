module "k8s_cluster" {
    source = "./k8s-cluster"
    namespace  = local.namespace
    certmgr = var.certmgr 
    nginxoss = var.nginxoss
    keycloak = var.keycloak
}

module "certmgr" {
    source = "./cert-manager"
    namespace = module.k8s_cluster.namespace
    mydomain = local.mydomain
    depends_on = [module.k8s_cluster]
}

module "keycloak" {
    count  = var.keycloak ? 1 : 0
    source = "./keycloak"
    namespace  = module.k8s_cluster.namespace
    password  = var.keycloak_password
    superadmin  = var.superadmin
    keycloak_ingress  = local.keycloak_ingress
    kibana_ingress  = local.kibana_ingress
    depends_on = [module.certmgr]
}

module "elastic" {
    source = "./eck"
    count  = var.eck ? 1 : 0
    namespace  = module.k8s_cluster.namespace
    password  = var.eck_password
    elastic_ingress  = local.elastic_ingress
    kibana_ingress  = local.kibana_ingress
    keycloak_ingress  = local.keycloak_ingress
    docker-desktop = var.docker-desktop
    hostAliases = local.hostAliases
    depends_on = [module.certmgr]
}
