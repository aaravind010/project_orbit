output "instance_piblic_ip" {
  value     = aws_instance.orbit_server.public_ip
  sensitive = false
}