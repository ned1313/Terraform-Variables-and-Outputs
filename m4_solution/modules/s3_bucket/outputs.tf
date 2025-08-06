output "bucket_arn" {
  description = "The ARN of the S3 bucket."
  value       = aws_s3_bucket.bucket.arn
}

output "bucket_id" {
  description = "The ID of the S3 bucket."
  value       = aws_s3_bucket.bucket.id
}

output "bucket_policy" {
  description = "The policy of the S3 bucket."
  value       = aws_s3_bucket_policy.bucket_policy.policy
}