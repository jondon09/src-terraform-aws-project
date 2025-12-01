output "s3_bucket_details" {
  description = "Output attributes of our s3 bucket"
  value = [
    "bucket Id: ${aws_s3_bucket.images-bucket.id}",
    "bucket ARN: ${aws_s3_bucket.images-bucket.arn}",
    "bucket Domain: ${aws_s3_bucket.images-bucket.bucket_domain_name}"

  ]
}

output "s3_bucket_to_import" {
  description = "Output attributes of our s3 bucket to import"
  value = [
    "bucket Id: ${aws_s3_bucket.resource_to_import.id}",
    "bucket ARN: ${aws_s3_bucket.resource_to_import.arn}",
    "bucket Domain: ${aws_s3_bucket.resource_to_import.bucket_domain_name}"

  ]
}