variable "DO_TOKEN" {
  type        = string
  description = "DigitalOcean API token, required and passed through environmental variable TF_VAR_DO_TOKEN"
}

variable "DO_PROJECT" {
  type        = string
  description = "Name of project within which relevant resources will be organized"
  default     = "do-tf-k8s"
}

variable "DO_REGION" {
  type        = string
  description = "Name of DigitalOcean region within which resources will be deployed"
  default     = "nyc3"
}

variable "DO_K8SSLUG" {
  type        = string
  description = "Slug indicating k8s version to deploy (see https://slugs.do-api.dev/)"
  default     = "1.28.2-do.0"
}
