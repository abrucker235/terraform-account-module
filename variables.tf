variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Region to create resources in"
}

variable "account_name" {
  type        = string
  description = "Name of the account to create"
}

variable "email" {
  type        = string
  description = "Email to use for account"
}

variable "parent_id" {
  type        = string
  description = "Organization/Unit parent identifier"
}

variable "flow_log_retention" {
  type        = number
  default     = 90
  description = "How long to retain vpc flowlogs in cloudwatch"
}

variable "cidr_block" {
  type        = string
  description = "CIDR Block to assign to VPC"
}

variable "public_a_cidr_block" {
  type        = string
  description = "CIDR Block for public subnet should be a /28"
}

variable "public_b_cidr_block" {
  type        = string
  description = "CIDR Block for public subnet should be a /28"
}

variable "public_c_cidr_block" {
  type        = string
  description = "CIDR Block for public subnet should be a /28"
}

variable "private_a_cidr_block" {
  type        = string
  description = "CIDR Block for private subnet"
}

variable "private_b_cidr_block" {
  type        = string
  description = "CIDR Block for private subnet"
}

variable "private_c_cidr_block" {
  type        = string
  description = "CIDR Block for private subnet"
}

variable "pod_cidr_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable secondary cidr for pods"
}

variable "pod_cidr_block" {
  type        = string
  default     = "100.64.0.0/16"
  description = "Secondary CIDR Block for pods"
}

variable "pod_a_cidr_block" {
  type        = string
  description = "CIDR Block for pod subnet"
}

variable "pod_b_cidr_block" {
  type        = string
  description = "CIDR Block for pod subnet"
}

variable "pod_c_cidr_block" {
  type        = string
  description = "CIDR Block for pod subnet"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
}