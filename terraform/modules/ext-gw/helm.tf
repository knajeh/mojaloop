locals {
  env_values = {
    db_host                = var.db_host
    db_port                = var.db_port
    db_user                = var.db_user
    db_password            = var.db_password
    keystore_password      = var.keystore_password
    extgw                  = var.extgw_fqdn
    iskm                   = var.iskm_fqdn
    iskm_internal          = "${var.wso2_iskm_helm_name}-${var.helm_deployment}"
    service_account_name   = var.service_account_name
    vault_role_name        = var.vault_role_name
    vault_secret_file_name = var.vault_secret_file_name
    vault_secret_name      = var.vault_secret_name
    vault_sim_wl_secret_name = var.vault_sim_wl_secret_name
    vault_sim_wl_secret_file_name = var.vault_sim_wl_secret_file_name
    vault_pm4ml_wl_secret_name = var.vault_pm4ml_wl_secret_name
    vault_pm4ml_wl_secret_file_name = var.vault_pm4ml_wl_secret_file_name
    wso2_admin_pw = var.wso2_admin_pw
  }
}

resource "helm_release" "app" {
  name          = "wso2-am-ext"
  repository    = "http://docs.mojaloop.io/wso2-helm-charts-simple/repo"
  chart         = "wso2-am"
  version       = "2.0.10"
  namespace     = var.namespace
  timeout       = 500
  force_update  = true
  create_namespace = true
  values = [
    file("${path.module}/helm/values.yaml"),
    templatefile("${path.module}/templates/env-values.yaml.tpl", local.env_values),
    templatefile("${path.module}/templates/annotations.yaml.tpl", local.env_values),
    templatefile("${path.module}/templates/sim_annotations.yaml.tpl", local.env_values),
    templatefile("${path.module}/templates/pm4ml_annotations.yaml.tpl", local.env_values)
  ]
  set {
    name  = "secret.externalSecretName"
    value = kubernetes_secret.secrets.metadata[0].name
    type  = "string"
  }
  set {
    name  = "configmap.externalConfigMapName"
    value = kubernetes_config_map.configs.metadata[0].name
    type  = "string"
  }
  set {
    name  = "binconfigmap.externalConfigMapName"
    value = kubernetes_config_map.binconfigs.metadata[0].name
    type  = "string"
  }
  set {
    name  = "externalServiceAccount.enabled"
    value = true
  }
  set {
    name  = "externalServiceAccount.serviceAccountName"
    value = var.service_account_name
    type  = "string"
  }
  set {
    name  = "persistentVolume.storageClass"
    value = var.efs_storage_class_name
    type  = "string"
  }
}
