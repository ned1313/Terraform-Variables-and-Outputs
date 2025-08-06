provider "aws" {
  region = var.region
}

locals {
  # Names for resources
  vpc_name      = "${local.naming_prefix}-vpc"
  sg_name       = "${local.naming_prefix}-sg"
  profile_name  = "${local.naming_prefix}-instance-profile"
  role_name     = "${local.naming_prefix}-role"
  instance_name = "${local.naming_prefix}-web"
  secret_name   = "${local.naming_prefix}-api-key"
  bucket_name   = local.naming_prefix
  subnet_names  = [for name in keys(var.vpc_network_info.public_subnets) : "${local.naming_prefix}-${name}"]
}

## Networking Resources

data "aws_availability_zones" "available" {
  state = "available"
}

module "networking" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  name = local.vpc_name
  cidr = var.vpc_network_info.vpc_cidr

  azs                     = slice(data.aws_availability_zones.available.names, 0, length(var.vpc_network_info.public_subnets))
  public_subnets          = values(var.vpc_network_info.public_subnets)
  public_subnet_names     = local.subnet_names
  enable_dns_hostnames    = true
  enable_dns_support      = true
  map_public_ip_on_launch = true

  tags = local.default_tags
}

## EC2 Instance resources

data "aws_ssm_parameter" "amzn2_linux" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_iam_instance_profile" "main" {
  name = local.profile_name
  role = aws_iam_role.main.name
}

resource "aws_iam_role" "main" {
  name               = local.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_instance" "web" {
  ami                         = nonsensitive(data.aws_ssm_parameter.amzn2_linux.value)
  instance_type               = var.instance_type
  subnet_id                   = module.networking.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.main.id]
  iam_instance_profile        = aws_iam_instance_profile.main.name
  user_data_replace_on_change = true
  user_data = templatefile("${path.module}/templates/user_data.sh",
    {
      environment = var.environment
  })

  tags = merge(local.default_tags, {
    Name = local.instance_name
  })
}

resource "aws_security_group" "main" {
  name   = local.sg_name
  vpc_id = module.networking.vpc_id

  # HTTP access from anywhere
  ingress {
    from_port   = var.sg_port_number
    to_port     = var.sg_port_number
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

## Other Resources

resource "aws_secretsmanager_secret" "api_secret" {
  name                           = local.secret_name
  description                    = "Secret to store API key"
  force_overwrite_replica_secret = true
  recovery_window_in_days        = 0
}

resource "aws_secretsmanager_secret_version" "api_secret_version" {
  secret_id     = aws_secretsmanager_secret.api_secret.id
  secret_string = var.api_key

}

module "storage" {
  source                = "./modules/s3_bucket"
  bucket_prefix         = local.bucket_name
  ec2_instance_role_arn = aws_iam_role.main.arn

  tags = local.default_tags
}
