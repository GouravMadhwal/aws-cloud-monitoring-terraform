variable "ami_id" {
  description = "This stores the AMI ID for the instance"
  type        = string
}

variable "instance_type_id" {
  description = "This stores the type of the instance you want to create"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID from the networking module"
  type        = string
}

variable "subnet_id" {
  description = "Public subnet ID from the networking module"
  type        = string
} 