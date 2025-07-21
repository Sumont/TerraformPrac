variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr_1" {
  description = "CIDR block for subnet 1"
  type        = string
}

variable "subnet_cidr_2" {
  description = "CIDR block for subnet 2"
  type        = string
}

variable "az_1" {
  description = "Availability Zone for subnet 1"
  type        = string
}

variable "az_2" {
  description = "Availability Zone for subnet 2"
  type        = string
}
