provider "aws" {
  region = var.region
}

## Networking Resources

data "aws_availability_zones" "available" {
  state = "available"
}

module "networking" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  name = var.vpc_network_info.vpc_name # var.vpc_network_info["vpc_name"] also works
  cidr = var.vpc_network_info.vpc_cidr

  azs                     = slice(data.aws_availability_zones.available.names, 0, length(var.vpc_network_info.public_subnets))
  public_subnets          = values(var.vpc_network_info.public_subnets)
  public_subnet_names     = keys(var.vpc_network_info.public_subnets)
  enable_dns_hostnames    = true
  enable_dns_support      = true
  map_public_ip_on_launch = true
}

## EC2 Instance resources

data "aws_ssm_parameter" "amzn2_linux" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_iam_instance_profile" "main" {
  name = "burrito_barn_instance_profile"
  role = aws_iam_role.main.name
}

resource "aws_iam_role" "main" {
  name               = "burrito_barn_role"
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

  tags = {
    Name = "web-instance"
  }
}

resource "aws_security_group" "main" {
  name   = "burrito_barn_sg"
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
  name                           = "api-key-bb"
  description                    = "Secret to store API key"
  force_overwrite_replica_secret = true
  recovery_window_in_days        = 0
}

resource "aws_secretsmanager_secret_version" "api_secret_version" {
  secret_id     = aws_secretsmanager_secret.api_secret.id
  secret_string = var.api_key #"BG^&*UJHJU*&^YUJHY&U"

}

module "storage" {
  source                = "./modules/s3_bucket"
  bucket_prefix         = var.bucket_prefix
  ec2_instance_role_arn = aws_iam_role.main.arn
}
