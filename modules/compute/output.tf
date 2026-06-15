output "instance_public_ip" {
  description = "The public IP address of the web server"
  value       = aws_instance.web_server.public_ip
}

output "instance_id" {
  description = "The instance ID of the web server"
  value       = aws_instance.web_server.id
}