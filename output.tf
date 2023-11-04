output "private_ip" {
  value = aws_instance.atlantis.private_ip
}

output "hostname" {
  value = var.hostname
}

output "instance_id" {
  value = aws_instance.atlantis.id
}
