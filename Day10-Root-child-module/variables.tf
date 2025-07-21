variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr_1" {
  description = "CIDR block for the first subnet"
  type        = string
}

variable "subnet_cidr_2" {
  description = "CIDR block for the second subnet"
  type        = string
}

variable "availability_zone_1" {
  description = "AZ for the first subnet"
  type        = string
}

variable "availability_zone_2" {
  description = "AZ for the second subnet"
  type        = string
}

variable "rds_instance_class" {
  type        = string
  description = "Instance class for the RDS DB"
}

variable "rds_db_name" {
  type        = string
  description = "Database name"
}

variable "rds_db_user" {
  type        = string
  description = "Database username"
}

variable "rds_db_password" {
  type        = string
  description = "Database password"
  sensitive   = true
}

variable "ec2_ami_id" {
  type        = string
  description = "AMI ID for EC2 instance"
}

variable "ec2_instance_type" {
  type        = string
  description = "EC2 instance type"
}
