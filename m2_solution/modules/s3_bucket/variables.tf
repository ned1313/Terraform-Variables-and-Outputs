/*

You need to add new variables to the s3_bucket module to configure the following:

Add a variable for tags to be applied to the bucket.


*/

variable "bucket_prefix" {
  description = "Prefix for S3 bucket name"
  type        = string
}

variable "ec2_instance_role_arn" {
  description = "The ARN of the EC2 instance role to allow access to the bucket"
  type        = string
}
