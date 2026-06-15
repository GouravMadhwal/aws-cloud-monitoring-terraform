variable "region" {
  description = "Region where resources should be created"
  type = string
  default = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the Public Subnet"
  type = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the Private Subnet"
  type = string
  default = "10.0.2.0/24"
}

variable "public_subnet_az" {
  description = "Availability Zone for the Public Subnet"
  type = string
  default = "ap-south-1a"
}

variable "private_subnet_az" {
  description = "Availability Zone for the Private Subnet"
  type = string
  default = "ap-south-1b"
}

variable "route_table_cidr" {
  description = "CIDR for the Route Table"
  type = string
  default = "0.0.0.0/0"
}

variable "ami_id" {
  description = "AMI ID for the web server"
  type = string
}

variable "instance_type_id" {
  description = "Instance type for the web server"
  type = string
  default = "t3.micro"
}

variable "email_id" {
  description = "Email ID for the SNS Subscription"
  type = string
}

variable "threshold_value" {
  description = "Threshold value for monitoring"
  type = number
  default = 70
}

variable "period_value" {
  description = "Period value for monitoring"
  type = number
  default = 30
}

variable "evaluation_periods_value" {
  description = "Evaluation Period value for monitoring"
  type = number
  default = 5
}