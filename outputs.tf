#--------------------------------------------------------------
# S3 Buckwet
#--------------------------------------------------------------

output "s3_bucket_id" {
  value       = element(concat(aws_s3_bucket.this[*].id, [""]), 0)
  description = "The name of the bucket."
}

output "s3_bucket_arn" {
  value       = element(concat(aws_s3_bucket.this[*].arn, [""]), 0)
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
}

output "s3_bucket_bucket_domain_name" {
  value       = element(concat(aws_s3_bucket.this[*].bucket_domain_name, [""]), 0)
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com."
}

output "s3_bucket_bucket_regional_domain_name" {
  value       = element(concat(aws_s3_bucket.this[*].bucket_regional_domain_name, [""]), 0)
  description = "The bucket region-specific domain name. The bucket domain name including the region name, please refer here for format. Note: The AWS CloudFront allows specifying S3 region-specific endpoint when creating S3 origin, it will prevent redirect issues from CloudFront to S3 Origin URL."
}

output "s3_bucket_hosted_zone_id" {
  value       = element(concat(aws_s3_bucket.this[*].hosted_zone_id, [""]), 0)
  description = "The Route 53 Hosted Zone ID for this bucket's region."
}

output "s3_bucket_region" {
  value       = element(concat(aws_s3_bucket.this[*].region, [""]), 0)
  description = "The AWS region this bucket resides in."
}

output "s3_bucket_tags_all" {
  value       = element(concat(aws_s3_bucket.this[*].tags_all, [""]), 0)
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
}

output "s3_bucket_website_endpoint" {
  value       = element(concat(aws_s3_bucket.this[*].website_endpoint, [""]), 0)
  description = "The website endpoint, if the bucket is configured with a website. If not, this will be an empty string."
}

output "s3_bucket_website_domain" {
  value       = element(concat(aws_s3_bucket.this[*].website_domain, [""]), 0)
  description = "The domain of the website endpoint, if the bucket is configured with a website. If not, this will be an empty string. This is used to create Route 53 alias records."
}

#--------------------------------------------------------------
# S3 Bucket Logging
#--------------------------------------------------------------

output "s3_bucket_logging_id" {
  value       = element(concat(aws_s3_bucket_logging.this[*].id, [""]), 0)
  description = "The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided."
}

#--------------------------------------------------------------
# S3 Bucket ACL
#--------------------------------------------------------------

output "s3_bucket_acl_id" {
  value       = element(concat(aws_s3_bucket_acl.this[*].id, [""]), 0)
  description = "The bucket, expected_bucket_owner (if configured), and acl (if configured) separated by commas (,)."
}

#--------------------------------------------------------------
# S3 Bucket Website Configuration
#--------------------------------------------------------------

output "s3_bucket_website_configuration_id" {
  value       = element(concat(aws_s3_bucket_website_configuration.this[*].id, [""]), 0)
  description = "The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided."
}

output "s3_bucket_website_configuration_website_domain" {
  value       = element(concat(aws_s3_bucket_website_configuration.this[*].website_domain, [""]), 0)
  description = "The domain of the website endpoint. This is used to create Route 53 alias records."
}

output "s3_bucket_website_configuration_website_endpoint" {
  value       = element(concat(aws_s3_bucket_website_configuration.this[*].website_endpoint, [""]), 0)
  description = "The website endpoint."
}

#--------------------------------------------------------------
# S3 Bucket Versioning
#--------------------------------------------------------------

output "s3_bucket_versioning_id" {
  value       = element(concat(aws_s3_bucket_versioning.this[*].id, [""]), 0)
  description = "The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided."
}

#--------------------------------------------------------------
# S3 Bucket Server Side Encryption Configuration
#--------------------------------------------------------------

output "s3_bucket_server_side_encryption_configuration_id" {
  value       = element(concat(aws_s3_bucket_server_side_encryption_configuration.this[*].id, [""]), 0)
  description = "The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided."
}

#--------------------------------------------------------------
# S3 Bucket Accelerate Configuration
#--------------------------------------------------------------

output "s3_bucket_accelerate_configuration_id" {
  value       = element(concat(aws_s3_bucket_accelerate_configuration.this[*].id, [""]), 0)
  description = "The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided."
}

#--------------------------------------------------------------
# S3 Bucket Request Payment Configuration
#--------------------------------------------------------------

output "s3_bucket_request_payment_configuration_id" {
  value       = element(concat(aws_s3_bucket_request_payment_configuration.this[*].id, [""]), 0)
  description = "The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided."
}

#--------------------------------------------------------------
# S3 Bucket CORS Configuration
#--------------------------------------------------------------

output "s3_bucket_cors_configuration_id" {
  value       = element(concat(aws_s3_bucket_cors_configuration.this[*].id, [""]), 0)
  description = "The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided."
}

#--------------------------------------------------------------
# S3 Bucket Lifecycle Configuration
#--------------------------------------------------------------

output "s3_bucket_lifecycle_configuration_id" {
  value       = element(concat(aws_s3_bucket_lifecycle_configuration.this[*].id, [""]), 0)
  description = "The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided."
}

#--------------------------------------------------------------
# S3 Bucket Object Lock Configuration
#--------------------------------------------------------------

output "s3_bucket_object_lock_configuration_id" {
  value       = element(concat(aws_s3_bucket_object_lock_configuration.this[*].id, [""]), 0)
  description = "The bucket or bucket and expected_bucket_owner separated by a comma (,) if the latter is provided."
}

#--------------------------------------------------------------
# S3 Bucket Replication Configuration
#--------------------------------------------------------------

output "s3_bucket_replication_configuration_id" {
  value       = element(concat(aws_s3_bucket_replication_configuration.this[*].id, [""]), 0)
  description = "The S3 source bucket name."
}

#--------------------------------------------------------------
# S3 Bucket Policy
#--------------------------------------------------------------

output "s3_bucket_policy_bucket" {
  value       = element(concat(aws_s3_bucket_policy.this[*].id, [""]), 0)
  description = "(Required) The name of the bucket to which to apply the policy."
}

output "s3_bucket_policy_policy" {
  value       = element(concat(aws_s3_bucket_policy.this[*].id, [""]), 0)
  description = "(Required) The text of the policy. Although this is a bucket policy rather than an IAM policy, the aws_iam_policy_document data source may be used, so long as it specifies a principal. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide. Note: Bucket policies are limited to 20 KB in size."
}

#--------------------------------------------------------------
# S3 Bucket Public Access Block
#--------------------------------------------------------------

output "s3_bucket_public_access_block_id" {
  value       = element(concat(aws_s3_bucket_public_access_block.this[*].id, [""]), 0)
  description = "Name of the S3 bucket the configuration is attached to"
}

#--------------------------------------------------------------
# S3 Bucket Ownership Controls
#--------------------------------------------------------------

output "s3_bucket_ownership_controls_id" {
  value       = element(concat(aws_s3_bucket_ownership_controls.this[*].id, [""]), 0)
  description = "S3 Bucket name."
}
