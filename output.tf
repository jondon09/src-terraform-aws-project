output "s3_bucket_details" {
  description = "Output attributes of our s3 bucket"
  value = [
    "bucket Id: ${aws_s3_bucket.images-bucket.id}",
    "bucket ARN: ${aws_s3_bucket.images-bucket.arn}",
    "bucket Domain: ${aws_s3_bucket.images-bucket.bucket_domain_name}"

  ]
}