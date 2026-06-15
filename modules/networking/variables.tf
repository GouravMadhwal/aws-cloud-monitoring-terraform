variable "cidr" {
    description = "This stores the CIDR Block of the Custom VPC"
    type = string
#   default = "10.0.0.0/16"
}

variable "public_cidr" {
    description = "This stores the CIDR Block of the Public Subnet"
    type = string
#   default = "10.0.1.0/24"
}

variable "private_cidr" {
    description = "This stores the CIDR Block of the Private Subnet"
    type = string
#   default = "10.0.2.0/24"
}

variable "public_subnet_az" {
    description = "This stores the availaibility zone for the public subnet"
    type = string
#   default = "ap-south-1a"
}

variable "private_subnet_az" {
    description = "This stores the availaibility zone for the private subnet"
    type = string
#   default = "ap-south-1a"
}

variable "route_table_cidr" {
    description = "This stores the Route Table CIDR"
    type = string
#   default = "0.0.0.0/0"
}