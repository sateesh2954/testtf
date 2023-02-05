variable "TF_VERSION" {
  default     = "1.1"
  description = "Terraform engine version to be used in schematics"
}

variable "zone" {
  description = "Availability zone of region."
  type        = string
}

variable "resource_group" {
  description = "Resource group name."
}

variable "vpc_name" {
  description = "The name of VPC."
  type        = string
}

variable "subnet_name" {
  description = "The name of subnet."
  type        = string
}
