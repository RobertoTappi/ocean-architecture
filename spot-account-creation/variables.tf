variable "account-name" {
    type        = string
    default = null
    description = "Name for the Spot account. The account name must contain at least one character that is a-z or A-Z"
}
variable "spotinst_token" {
    type        = string
    default = null
    sensitive   = true
    description = "Spot API Token"
}
variable "policy_file" {
    type        = string
    default     = null
    description = "Provide Custom IAM Policy File in JSON format"
}
variable "region-name" {
    type        = string
    default     = null
    description = "Provide region code"
}
variable "account-id" {
    type        = string
    default     = null
    sensitive = true
    description = " Provide account id"
}