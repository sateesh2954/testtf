### About VPC resources
variable "vpc_name" {
  type        = string
  description = "Name of an existing VPC in which the cluster resources will be deployed. If no value is given, then a new VPC will be provisioned for the cluster. [Learn more](https://cloud.ibm.com/docs/vpc)"
  default     = ""
}

variable "api_key" {
  type        = string
  sensitive   = true
  description = "This is the API key for IBM Cloud account in which the Spectrum Symphony cluster needs to be deployed. [Learn more](https://cloud.ibm.com/docs/account?topic=account-userapikey)."
  validation {
    condition     = var.api_key != ""
    error_message = "API key for IBM Cloud must be set."
  }
}

variable "resource_group" {
  type        = string
  default     = "Default"
  description = "Resource group name from your IBM Cloud account where the VPC resources should be deployed. [Learn more](https://cloud.ibm.com/docs/account?topic=account-rgs)."
}
