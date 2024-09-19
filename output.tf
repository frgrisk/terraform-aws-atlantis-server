output "private_ip" {
  value = var.spot_instance ? aws_spot_instance_request.atlantis[0].private_ip : aws_instance.atlantis[0].private_ip
}

output "hostname" {
  value = var.hostname
}

output "instance_id" {
  value = var.spot_instance ? aws_spot_instance_request.atlantis[0].spot_instance_id : aws_instance.atlantis[0].id
}
