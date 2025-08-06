variable "api_key" {
  description = "API key to be stored in Secrets Manager."
  type        = string
  sensitive   = true
}

variable "bucket_prefix" {
  description = "Prefix to use for naming the S3 bucket."
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)."
  type        = string
  default     = "dev"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance."
  type        = string
}

variable "region" {
  description = "AWS Region to deploy resources in."
  type        = string
  default     = "us-west-2"
}

variable "sg_port_number" {
  description = "Port number for the security group."
  type        = number
  default     = 80
}

variable "vpc_network_info" {
  description = "Values for VPC module."
  type = object({
    vpc_name       = string
    vpc_cidr       = string
    public_subnets = map(string) # subnet name to CIDR
  })
}
