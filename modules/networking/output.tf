output "vpc_id" {
  description = "Custom VPC ID"
  value       = aws_vpc.custom_vpc.id
}

output "public_subnet_id" {
  description = "Public Subnet ID"
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "Private Subnet ID"
  value       = aws_subnet.private_subnet.id
}

output "route_table_id" {
  description = "Route Table ID"
  value       = aws_route_table.custom_rt.id
}