/*

You need to add new variables to the s3_bucket module to configure the following:

Add a variable for tags to be applied to the bucket.


*/

variable "bucket_prefix" {
  description = "Prefix for S3 bucket name"
  type        = string
}
