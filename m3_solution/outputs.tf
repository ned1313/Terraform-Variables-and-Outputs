/*
 Future Enhancements (Output Values topic):

Add description for outputs.

Use sensitive = true for sensitive outputs.

Add new outputs from the locals.

Update child module to expose more useful values (ARN, region, etc).
*/

output "vpc_id" {
  value = module.networking.vpc_id
}

output "ec2_public_ip" {
  value = aws_instance.web.public_ip
}
