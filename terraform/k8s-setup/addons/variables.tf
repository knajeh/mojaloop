variable "environment" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "client" {
  description = "Client name"
  type        = string
}

variable "bucket" {
  description = "Name of aws s3 bucket"
  type        = string
}
variable "project_root_path" {
  description = "Root path for IaC project"
}

variable "hub_account_names" {
  description = "other non sim account names. this will create accounts and whitelist entries"
  type        = list(string)
  default     = ["noresponsepayeefsp"]
}

variable "hub_account_cidr_blocks" {
  description = "hubaccount CIDR Block"
  type        = list(string)
  default     = ["10.0.0.0/8"]
}

variable "hub_currency_code" {
  description = "currency code for the hub"
  type        = string
}

variable "iac_post_init_version" {
  description = "tag on iac post init repo"
  type        = string
}

variable "helm_mojaloop_version" {
  description = "Mojaloop version to install via Helm"
}

variable "helm_mojaloop_release_name" {
  description = "Mojaloop helm release name"
  default = "mojaloop"
}

variable "private_registry_pw" {
  description = "pw for private registry"
  type        = string
  default     = "override this for private image repo usage"
}

variable "use_alias_oracle_endpoint" {
  description = "use alias oracle instead of internal"
  type        = string
  default     = "no"
}

variable "internal_pm4ml_configs" {
  description = "pm4ml config data"
  type = list(object({
    DFSP_NAME         = string
    DFSP_CURRENCY     = string
    DFSP_PREFIX       = string
    DFSP_P2P_PREFIX   = string
    DFSP_MSISDN       = string
    DFSP_ACCOUNT_ID   = string
    DFSP_ALIAS_ID     = string
    DFSP_NOTIFICATION_EMAIL = string
    PARTY_LAST_NAME = string
    PARTY_FIRST_NAME = string
    PARTY_MIDDLE_NAME = string
    PARTY_DOB = string
    TTK_ENABLED = bool
    TTK_PAYEE_SIMULATOR_ENABLED = bool
  }))
  default = []
}

variable "external_pm4ml_configs" {
  description = "pm4ml config data"
  type = list(object({
    DFSP_NAME         = string
    DFSP_CURRENCY     = string
    DFSP_PREFIX       = string
    DFSP_P2P_PREFIX   = string
    DFSP_NOTIFICATION_EMAIL = string
    DFSP_SUBDOMAIN = string
    TTK_ENABLED = bool
    TTK_PAYEE_SIMULATOR_ENABLED = bool
  }))
  default = []
}

variable "mcm_name" {
  description = "Hostname of Connection Manager service"
  type        = string
  default     = "mcm"
}
