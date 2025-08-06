locals {
  default_tags = merge(var.tags, {
    Environment = var.environment
    Project     = var.project
  })

  naming_prefix = "${var.project}-${var.environment}"
}