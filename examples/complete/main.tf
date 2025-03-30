#--------------------------------------------------------------
# Main
#--------------------------------------------------------------

provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {}
data "aws_canonical_user_id" "current" {}
data "aws_cloudfront_log_delivery_canonical_user_id" "cloudfront" {}

locals {
  aws_account_id         = data.aws_caller_identity.current.account_id
  bucket                 = "example-${var.region}-${local.aws_account_id}"
  logs_bucket            = "example-logs-${var.region}-${local.aws_account_id}"
  cloudfront_logs_bucket = "example-cloudfront-logs-${var.region}-${local.aws_account_id}"
}

resource "aws_kms_key" "s3" {
  description             = "KMS key is used to encrypt bucket objects"
  enable_key_rotation     = true
  deletion_window_in_days = 7
}

data "aws_iam_policy_document" "ec2_assume_role_policy" {
  statement {
    sid    = "Ec2AssumeRole"
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "instance_role" {
  name               = "EC2InstanceRole"
  path               = "/org/"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json
}

data "aws_iam_policy_document" "s3_bucket_policy" {
  statement {
    sid    = "S3ReadWrite"
    effect = "Allow"
    actions = [
      "s3:Get*",
      "s3:List*",
      "s3:Put*",
    ]
    resources = [
      "arn:aws:s3:::${local.bucket}",
      "arn:aws:s3:::${local.bucket}/*",
    ]
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.instance_role.arn]
    }
  }
}

module "log_bucket" {
  source = "../../"

  bucket        = local.logs_bucket
  force_destroy = true

  # acl
  enable_acl = true
  acl        = "log-delivery-write"

  # bucket policies
  enable_policy                         = true
  attach_deny_insecure_transport_policy = true
  attach_require_latest_tls_policy      = true
}

module "cloudfront_log_bucket" {
  source = "../../"

  bucket        = local.cloudfront_logs_bucket
  force_destroy = true

  # acl
  enable_acl = true
  acl_access_control_policy = [
    {
      grant = [
        {
          permission = "FULL_CONTROL"
          grantee = [{
            id   = data.aws_canonical_user_id.current.id
            type = "CanonicalUser"
          }]
        },
        {
          permission = "FULL_CONTROL"
          grantee = [{
            type = "CanonicalUser"
            id   = data.aws_cloudfront_log_delivery_canonical_user_id.cloudfront.id # Ref. https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/AccessLogs.html
          }]
        },
      ]
      owner = [{
        id = data.aws_canonical_user_id.current.id
      }]
    }
  ]
}

module "s3_bucket" {
  source = "../../"

  bucket              = local.bucket
  force_destroy       = true
  object_lock_enabled = true
  tags = {
    Owner = "hansohn"
  }

  # accelerate_configuration
  enable_accelerate_configuration = true
  accelerate_status               = "Suspended"

  # request_payment_configuration
  enable_request_payment_configuration = true
  request_payment_payer                = "BucketOwner"

  # Note: Object Lock configuration can be enabled only on new buckets
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object_lock_configuration
  # object_lock_configuration
  enable_object_lock_configuration = true
  object_lock_rule = [{
    default_retention = {
      mode = "GOVERNANCE"
      days = 1
    }
  }]

  # bucket policies
  enable_policy                         = true
  policy                                = data.aws_iam_policy_document.s3_bucket_policy.json
  attach_deny_insecure_transport_policy = true
  attach_require_latest_tls_policy      = true

  # S3 Bucket Ownership Controls
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls
  enable_ownership_controls       = true
  ownership_rule_object_ownership = "BucketOwnerEnforced"

  # acl
  enable_acl                = true
  acl                       = "private" # "acl" conflicts with "grant" and "owner"
  acl_expected_bucket_owner = data.aws_caller_identity.current.account_id

  # logging
  enable_logging        = true
  logging_target_bucket = module.log_bucket.id
  logging_target_prefix = "log/"

  # versioning
  enable_versioning = true
  versioning_configuration = {
    status     = "Enabled"
    mfa_delete = "Disabled"
  }

  # website configuration
  enable_website_configuration = true
  website_index_document = [{
    suffix = "index.html"
  }]
  website_error_document = [{
    key = "error.html"
  }]
  website_routing_rule = [
    {
      condition = [{
        key_prefix_equals = "docs/"
      }]
      redirect = {
        replace_key_prefix_with = "documents/"
      }
    },
    {
      condition = [{
        http_error_code_returned_equals = 404
        key_prefix_equals               = "archive/"
      }]
      redirect = {
        host_name          = "archive.myhost.com"
        http_redirect_code = 301
        protocol           = "https"
        replace_key_with   = "not_found.html"
      }
    }
  ]

  # server_side_encryption_configuration
  encryption_sse_algorithm     = "aws:kms"
  encryption_kms_master_key_id = aws_kms_key.s3.arn

  # cors_configuration
  enable_cors_configuration = true
  cors_rule = [
    {
      allowed_methods = ["PUT", "POST"]
      allowed_origins = ["https://modules.tf", "https://terraform-aws-modules.modules.tf"]
      allowed_headers = ["*"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
    },
    {
      allowed_methods = ["PUT"]
      allowed_origins = ["https://example.com"]
      allowed_headers = ["*"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
    }
  ]

  # lifecycle_configuration
  enable_lifecycle_configuration = true
  lifecycle_rule = [
    {
      id     = "InfrequentAccess"
      status = "Enabled"

      filter = [
        {
          prefix = ""
        }
      ]

      transition = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 60
          storage_class = "GLACIER"
        }
      ]
    },
    {
      id     = "NoncurrentVersion"
      status = "Enabled"

      filter = [
        {
          prefix = ""
        }
      ]

      abort_incomplete_multipart_upload = [
        {
          days_after_initiation = 7
        }
      ]

      noncurrent_version_transition = [
        {
          noncurrent_days = 0
          storage_class   = "STANDARD_IA"
        },
        {
          noncurrent_days = 30
          storage_class   = "GLACIER"
        },
      ]

      noncurrent_version_expiration = [
        {
          newer_noncurrent_versions = 2
          noncurrent_days           = 60
        }
      ]
    },
  ]

  # intelligent_tiering_configuration
  enable_intelligent_tiering_configuration = true
  intelligent_tiering_configuration = {
    general = {
      status = "Enabled"
      filter = [{
        prefix = "/"
        tags = {
          Environment = "dev"
        }
      }]
      tiering = [
        {
          access_tier = "ARCHIVE_ACCESS"
          days        = 180
        },
      ]
    },
    documents = {
      status = "Disabled"
      filter = [{
        prefix = "documents/"
      }]
      tiering = [
        {
          access_tier = "ARCHIVE_ACCESS"
          days        = 125
        },
        {
          access_tier = "DEEP_ARCHIVE_ACCESS"
          days        = 200
        },
      ]
    }
  }

  # metric
  enable_metric = true
  metric_configuration = {
    documents = {
      filter = [{
        prefix = "documents/"
        tags = {
          priority = "high"
        }
      }]
    },
    other = {
      filter = [{
        tags = {
          production = "true"
        }
      }]
    },
    all = {},
  }
}
