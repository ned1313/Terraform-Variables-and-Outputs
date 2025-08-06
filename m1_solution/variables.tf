variable "api_key" {
  description = "API key to be stored in Secrets Manager."
  sensitive   = true
}

variable "bucket_prefix" {
  description = "Prefix to use for naming the S3 bucket."
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)."
  default     = "dev"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance."
}

variable "region" {
  description = "AWS Region to deploy resources in."
  default     = "us-west-2"
}

variable "sg_port_number" {
  description = "Port number for the security group."
  default     = 80
}
