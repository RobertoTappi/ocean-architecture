variable "spotinst_token" {
  type        = string
  description = "Spot Personal Access token"
  default = null
}

variable "spotinst_account" {
  type        = string
  description = "Spot account ID"
  default = null
}

variable "cluster_identifier" {
  type        = string
  description = "Cluster identifier"
  default = null
}

variable "region-name" {
    type        = string
    default     = null
    description = "Provide region code"
}
