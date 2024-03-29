resource "kubernetes_storage_class" "slow-add-ons" {
  metadata {
    name = "slow"
  }
  storage_provisioner = "kubernetes.io/aws-ebs"
  reclaim_policy      = "Retain"
  parameters = {
    type      = "gp2"
    iopsPerGB = "10"
    fsType    = "ext4"
  }
  provider = kubernetes.k8s-add-ons
}

#monitoring and logging deployments
resource "helm_release" "prometheus-add-ons" {
  name         = "prometheus"
  repository   = "https://charts.helm.sh/stable"
  chart        = "prometheus"
  version      = var.helm_prometheus_version
  namespace    = "monitoring"
  force_update = true
  create_namespace = true

  values = [
    file("${var.project_root_path}/helm/values-workload-clusters-prometheus.yaml")
  ]
  set {
    name  = "server.ingress.hosts"
    value = "{${data.terraform_remote_state.infrastructure.outputs.prometheus-add-ons-private-fqdn}}"
    type  = "string"
  }
  provider = helm.helm-add-ons

  depends_on = [kubernetes_storage_class.slow-add-ons]
}

resource "helm_release" "fluentd-add-ons" {
  name         = "fluentd-add-ons"
  repository   = "https://kiwigrid.github.io"
  chart        = "fluentd-elasticsearch"
  version      = var.helm_fluentd_version
  namespace    = "logging"
  force_update = true
  create_namespace = true

  values = [
    file("${var.project_root_path}/helm/values-workload-clusters-efk-fluentd.yaml")
  ]
  set {
    name  = "elasticsearch.host"
    value = data.terraform_remote_state.infrastructure.outputs.elasticsearch-services-private-fqdn
    type  = "string"
  }
  set {
    name  = "elasticsearch.port"
    value = "30000"
    type  = "string"
  }
  provider = helm.helm-add-ons
}

resource "helm_release" "deploy-addons-nginx-ingress-controller" {
  name       = "nginx-ingress"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"
  version    = var.helm_nginx_version
  namespace  = "default"
  wait       = false
  create_namespace = true

  set {
    name  = "service.nodePorts.http"
    value = 30001
  }
  provider = helm.helm-add-ons
}
