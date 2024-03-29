#create security related elements in current cluster
locals {
  #kube_master_url = yamldecode(file("${var.project_root_path}/admin-gateway.conf"))["clusters"].cluster[0].server
  kube_master_url = "https://${data.terraform_remote_state.infrastructure.outputs.gateway_k8s_master_nodes_private_ip[0]}:6443"
}

resource "kubernetes_service_account" "vault-auth-gateway" {
  metadata {
    name      = "vault-auth-gateway"
    namespace = var.wso2_namespace
  }
  automount_service_account_token = true
  provider                        = kubernetes.k8s-gateway
  depends_on = [module.wso2_init]
}

resource "kubernetes_cluster_role_binding" "role-tokenreview-binding-gateway" {
  metadata {
    name = "role-tokenreview-binding-vault"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "system:auth-delegator"
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.vault-auth-gateway.metadata[0].name
    namespace = var.wso2_namespace
  }
  provider   = kubernetes.k8s-gateway
}

data "kubernetes_secret" "generated-vault-auth-gateway" {
  metadata {
    name      = kubernetes_service_account.vault-auth-gateway.default_secret_name
    namespace = var.wso2_namespace
  }
  provider   = kubernetes.k8s-gateway
  depends_on = [kubernetes_cluster_role_binding.role-tokenreview-binding-gateway]
}

resource "vault_auth_backend" "kubernetes-gateway" {
  type = "kubernetes"
  path = var.kubernetes_auth_path
}

resource "vault_kubernetes_auth_backend_config" "kubernetes-gateway" {
  backend            = vault_auth_backend.kubernetes-gateway.path
  kubernetes_host    = local.kube_master_url
  kubernetes_ca_cert = split(".", var.k8s_api_version)[1] > 18 ? null : data.kubernetes_secret.generated-vault-auth-gateway.data["ca.crt"]
  token_reviewer_jwt = split(".", var.k8s_api_version)[1] > 18 ? null : data.kubernetes_secret.generated-vault-auth-gateway.data.token
  issuer             = "https://kubernetes.default.svc.cluster.local"
  disable_iss_validation = split(".", var.k8s_api_version)[1] > 18 ? "false" : "true"
}

resource "vault_policy" "base-token-polcies" {
  name = "base-token-polcies"

  policy = <<EOT
path "auth/token/lookup-accessor" {
  capabilities = ["update"]
}

path "auth/token/revoke-accessor" {
  capabilities = ["update"]
}
EOT
}

resource "vault_policy" "read-whitelist-addresses-gateway" {
  name = "whitelist_read_policy"

  policy = <<EOT
path "${var.whitelist_secret_name_prefix}*" {
  capabilities = ["read", "list"]
}
EOT
}

resource "vault_token" "haproxy-vault-token" {
  policies  = [vault_policy.read-whitelist-addresses-gateway.name, vault_policy.base-token-polcies.name]
  renewable = true
}

resource "vault_kubernetes_auth_backend_role" "kubernetes-gateway" {
  backend                          = vault_auth_backend.kubernetes-gateway.path
  role_name                        = "kubernetes-gateway-role"
  bound_service_account_names      = [kubernetes_service_account.vault-auth-gateway.metadata[0].name]
  bound_service_account_namespaces = [var.wso2_namespace]
  token_ttl                        = 3600
  token_policies                   = [vault_policy.read-whitelist-addresses-gateway.name]
}
