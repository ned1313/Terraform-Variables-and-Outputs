output "vpc_id" {
  value = module.networking.vpc_id
}

output "ec2_public_ip" {
  value = aws_instance.web.public_ip
}
