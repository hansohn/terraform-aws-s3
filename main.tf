data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.id
  attach_policy = var.enable_policy && anytrue([
    var.attach_deny_insecure_transport_policy,
    var.attach_inventory_destination_policy,
    var.attach_require_latest_tls_policy,
    var.policy != null,
  ])
}

#--------------------------------------------------------------
# S3 Buckwet
#--------------------------------------------------------------

#tfsec:ignore:aws-s3-enable-bucket-logging tfsec:ignore:aws-s3-enable-versioning
resource "aws_s3_bucket" "this" {
  count               = var.enable ? 1 : 0
  bucket              = var.bucket
  bucket_prefix       = var.bucket_prefix
  force_destroy       = var.force_destroy
  object_lock_enabled = var.object_lock_enabled
  tags                = var.tags
}

#--------------------------------------------------------------
# S3 Bucket Logging
#--------------------------------------------------------------

resource "aws_s3_bucket_logging" "this" {
  count                 = var.enable && var.enable_logging ? 1 : 0
  bucket                = aws_s3_bucket.this[0].id
  expected_bucket_owner = var.logging_expected_bucket_owner
  target_bucket         = var.logging_target_bucket
  target_prefix         = var.logging_target_prefix
  dynamic "target_grant" {
    for_each = var.logging_target_grant
    content {
      permission = target_grant.value.permission
      grantee {
        email_address = lookup(target_grant.value.grantee, "email_address", null)
        id            = lookup(target_grant.value.grantee, "id", null)
        type          = target_grant.value.grantee.type
        uri           = lookup(target_grant.value.grantee, "uri", null)
      }
    }
  }
}

#--------------------------------------------------------------
# S3 Bucket ACL
#--------------------------------------------------------------

resource "aws_s3_bucket_acl" "this" {
  count                 = var.enable && var.enable_acl ? 1 : 0
  bucket                = aws_s3_bucket.this[0].id
  expected_bucket_owner = var.acl_expected_bucket_owner
  acl                   = var.acl
  dynamic "access_control_policy" {
    for_each = var.acl_access_control_policy
    content {
      dynamic "grant" {
        for_each = lookup(access_control_policy.value, "grant", [])
        content {
          permission = grant.value.permission
          dynamic "grantee" {
            for_each = lookup(grant.value, "grantee", [])
            content {
              email_address = lookup(grantee.value, "email_address", null)
              id            = lookup(grantee.value, "id", null)
              type          = grantee.value.type
              uri           = lookup(grantee.value, "uri", null)
            }
          }
        }
      }
      dynamic "owner" {
        for_each = access_control_policy.value.owner
        content {
          id           = owner.value.id
          display_name = lookup(owner.value, "display_name", null)
        }
      }
    }
  }
}

#--------------------------------------------------------------
# S3 Bucket Website Configuration
#--------------------------------------------------------------

resource "aws_s3_bucket_website_configuration" "this" {
  count                 = var.enable && var.enable_website_configuration ? 1 : 0
  bucket                = aws_s3_bucket.this[0].id
  expected_bucket_owner = var.website_expected_bucket_owner
  routing_rules         = var.website_routing_rules
  dynamic "error_document" {
    for_each = var.website_error_document
    content {
      key = error_document.value.key
    }
  }
  dynamic "index_document" {
    for_each = var.website_index_document
    content {
      suffix = index_document.value.suffix
    }
  }
  dynamic "redirect_all_requests_to" {
    for_each = var.website_redirect_all_requests_to
    content {
      host_name = redirect_all_requests_to.value.host_name
      protocol  = lookup(redirect_all_requests_to.value, "protocol", null)
    }
  }
  dynamic "routing_rule" {
    for_each = var.website_routing_rule
    content {
      dynamic "condition" {
        for_each = lookup(routing_rule.value, "condition", [])
        content {
          http_error_code_returned_equals = lookup(condition.value, "http_error_code_returned_equals", null)
          key_prefix_equals               = lookup(condition.value, "key_prefix_equals", null)
        }
      }
      redirect {
        host_name               = lookup(routing_rule.value.redirect, "host_name", null)
        http_redirect_code      = lookup(routing_rule.value.redirect, "http_redirect_code", null)
        protocol                = lookup(routing_rule.value.redirect, "protocol", null)
        replace_key_prefix_with = lookup(routing_rule.value.redirect, "replace_key_prefix_with", null)
        replace_key_with        = lookup(routing_rule.value.redirect, "replace_key_with", null)
      }
    }
  }
}

#--------------------------------------------------------------
# S3 Bucket Versioning
#--------------------------------------------------------------

resource "aws_s3_bucket_versioning" "this" {
  count                 = var.enable && var.enable_versioning ? 1 : 0
  bucket                = aws_s3_bucket.this[0].id
  expected_bucket_owner = var.versioning_expected_bucket_owner
  mfa                   = var.versioning_mfa
  versioning_configuration {
    status     = "Enabled"
    mfa_delete = lookup(var.versioning_configuration, "mfa_delete", null)
  }
}

#--------------------------------------------------------------
# S3 Bucket Server Side Encryption Configuration
#--------------------------------------------------------------

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count                 = var.enable && var.enable_server_side_encryption_configuration ? 1 : 0
  bucket                = aws_s3_bucket.this[0].id
  expected_bucket_owner = var.encryption_expected_bucket_owner
  rule {
    bucket_key_enabled = var.encryption_bucket_key_enabled
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.encryption_sse_algorithm
      kms_master_key_id = var.encryption_kms_master_key_id
    }
  }
}

#--------------------------------------------------------------
# S3 Bucket Accelerate Configuration 
#--------------------------------------------------------------

resource "aws_s3_bucket_accelerate_configuration" "this" {
  count                 = var.enable && var.enable_accelerate_configuration ? 1 : 0
  bucket                = aws_s3_bucket.this[0].id
  expected_bucket_owner = var.accelerate_expected_bucket_owner
  status                = var.accelerate_status
}

#--------------------------------------------------------------
# S3 Bucket Request Payment Configuration
#--------------------------------------------------------------

resource "aws_s3_bucket_request_payment_configuration" "this" {
  count                 = var.enable && var.enable_request_payment_configuration ? 1 : 0
  bucket                = aws_s3_bucket.this[0].id
  expected_bucket_owner = var.request_payment_expected_bucket_owner
  payer                 = var.request_payment_payer
}

#--------------------------------------------------------------
# S3 Bucket CORS Configuration
#--------------------------------------------------------------

resource "aws_s3_bucket_cors_configuration" "this" {
  count                 = var.enable && var.enable_cors_configuration ? 1 : 0
  bucket                = aws_s3_bucket.this[0].id
  expected_bucket_owner = var.cors_expected_bucket_owner
  dynamic "cors_rule" {
    for_each = var.cors_rule
    content {
      allowed_headers = lookup(cors_rule.value, "allowed_headers", null)
      allowed_methods = cors_rule.value.allowed_methods
      allowed_origins = cors_rule.value.allowed_origins
      expose_headers  = lookup(cors_rule.value, "expose_headers", null)
      id              = lookup(cors_rule.value, "id", null)
      max_age_seconds = lookup(cors_rule.value, "max_age_seconds", null)
    }
  }
}

#--------------------------------------------------------------
# S3 Bucket Lifecycle Configuration
#--------------------------------------------------------------

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count                 = var.enable && var.enable_lifecycle_configuration ? 1 : 0
  bucket                = aws_s3_bucket.this[0].id
  expected_bucket_owner = var.lifecycle_expected_bucket_owner
  dynamic "rule" {
    for_each = var.lifecycle_rule
    content {
      id     = rule.value.id
      status = rule.value.status
      dynamic "abort_incomplete_multipart_upload" {
        for_each = lookup(rule.value, "abort_incomplete_multipart_upload", [])
        content {
          days_after_initiation = lookup(abort_incomplete_multipart_upload.value, "days_after_initiation", null)
        }
      }
      dynamic "expiration" {
        for_each = lookup(rule.value, "expiration", [])
        content {
          date                         = lookup(expiration.value, "date", null)
          days                         = lookup(expiration.value, "days", null)
          expired_object_delete_marker = lookup(expiration.value, "expired_object_delete_marker", null)
        }
      }
      dynamic "filter" {
        for_each = lookup(rule.value, "filter", [])
        content {
          object_size_greater_than = lookup(filter.value, "object_size_greater_than", null)
          object_size_less_than    = lookup(filter.value, "object_size_less_than", null)
          prefix                   = lookup(filter.value, "prefix", null)
          dynamic "and" {
            for_each = lookup(filter.value, "and", [])
            content {
              object_size_greater_than = lookup(and.value, "object_size_greater_than", null)
              object_size_less_than    = lookup(and.value, "object_size_less_than", null)
              prefix                   = lookup(and.value, "prefix", null)
              tags                     = lookup(and.value, "tags", null)
            }
          }
          dynamic "tag" {
            for_each = lookup(filter.value, "tag", [])
            content {
              key   = tag.key
              value = tag.value
            }
          }
        }
      }
      dynamic "noncurrent_version_expiration" {
        for_each = lookup(rule.value, "noncurrent_version_expiration", [])
        content {
          newer_noncurrent_versions = lookup(noncurrent_version_expiration.value, "newer_noncurrent_versions", null)
          noncurrent_days           = lookup(noncurrent_version_expiration.value, "noncurrent_days", null)
        }
      }
      dynamic "noncurrent_version_transition" {
        for_each = lookup(rule.value, "noncurrent_version_transition", [])
        content {
          newer_noncurrent_versions = lookup(noncurrent_version_transition.value, "newer_noncurrent_versions", null)
          noncurrent_days           = lookup(noncurrent_version_transition.value, "noncurrent_days", null)
          storage_class             = noncurrent_version_transition.value.storage_class
        }
      }
      dynamic "transition" {
        for_each = lookup(rule.value, "transition", [])
        content {
          date          = lookup(transition.value, "date", null)
          days          = lookup(transition.value, "days", null)
          storage_class = lookup(transition.value, "storage_class", null)
        }
      }
    }
  }

  depends_on = [
    aws_s3_bucket_versioning.this
  ]
}

#--------------------------------------------------------------
# S3 Bucket Object Lock Configuration
#--------------------------------------------------------------

resource "aws_s3_bucket_object_lock_configuration" "this" {
  count                 = var.enable && var.enable_object_lock_configuration ? 1 : 0
  bucket                = aws_s3_bucket.this[0].id
  expected_bucket_owner = var.object_lock_expected_bucket_owner
  object_lock_enabled   = var.object_lock_object_lock_enabled
  token                 = var.object_lock_token
  dynamic "rule" {
    for_each = var.object_lock_rule
    content {
      default_retention {
        days  = lookup(rule.value.default_retention, "days", null)
        mode  = rule.value.default_retention.mode
        years = lookup(rule.value.default_retention, "years", null)
      }
    }
  }
}

#--------------------------------------------------------------
# S3 Bucket Replication Configuration
#--------------------------------------------------------------

resource "aws_s3_bucket_replication_configuration" "this" {
  count  = var.enable && var.enable_replication_configuration ? 1 : 0
  bucket = aws_s3_bucket.this[0].id
  role   = var.replication_role
  token  = var.replication_token
  rule {
    id       = lookup(var.replication_rule, "id", null)
    prefix   = lookup(var.replication_rule, "prefix", null)
    priority = lookup(var.replication_rule, "priority", null)
    status   = var.replication_rule.status
    dynamic "delete_marker_replication" {
      for_each = lookup(var.replication_rule, "delete_marker_replication", [])
      content {
        status = delete_marker_replication.value.status
      }
    }
    destination {
      account       = lookup(var.replication_rule.destination, "account", null)
      bucket        = var.replication_rule.destination.bucket
      storage_class = lookup(var.replication_rule.destination, "storage_class", null)
      dynamic "access_control_translation" {
        for_each = lookup(var.replication_rule.destination, "access_control_translation", [])
        content {
          owner = access_control_translation.value.owner
        }
      }
      dynamic "encryption_configuration" {
        for_each = lookup(var.replication_rule.destination, "encryption_configuration", [])
        content {
          replica_kms_key_id = encryption_configuration.value.replica_kms_key_id
        }
      }
      dynamic "metrics" {
        for_each = lookup(var.replication_rule.destination, "metrics", [])
        content {
          status = metrics.value.status
          dynamic "event_threshold" {
            for_each = lookup(metrics.value, "event_threshold", [])
            content {
              minutes = event_threshold.value.minutes
            }
          }
        }
      }
      dynamic "replication_time" {
        for_each = lookup(var.replication_rule.destination, "replication_time", [])
        content {
          status = replication_time.value.status
          time {
            minutes = replication_time.time.minutes
          }
        }
      }
    }
    dynamic "existing_object_replication" {
      for_each = lookup(var.replication_rule, "existing_object_replication", [])
      content {
        status = existing_object_replication.value.status
      }
    }
    dynamic "filter" {
      for_each = lookup(var.replication_rule, "filter", [])
      content {
        prefix = lookup(filter.value, "prefix", null)
        dynamic "and" {
          for_each = lookup(filter.value, "and", [])
          content {
            prefix = lookup(and.value, "prefix", null)
            tags   = lookup(and.value, "tags", null)
          }
        }
        dynamic "tag" {
          for_each = lookup(filter.value, "tag", [])
          content {
            key   = tag.value.key
            value = tag.value.value
          }
        }
      }
    }
    dynamic "source_selection_criteria" {
      for_each = lookup(var.replication_rule, "source_selection_criteria", [])
      content {
        dynamic "replica_modifications" {
          for_each = lookup(source_selection_criteria.value, "replica_modifications", [])
          content {
            status = replica_modifications.value.status
          }
        }
        dynamic "sse_kms_encrypted_objects" {
          for_each = lookup(source_selection_criteria.value, "sse_kms_encrypted_objects", [])
          content {
            status = sse_kms_encrypted_objects.value.status
          }
        }
      }
    }
  }

  depends_on = [
    aws_s3_bucket_versioning.this
  ]
}

#--------------------------------------------------------------
# S3 Bucket Policy
#--------------------------------------------------------------

data "aws_iam_policy_document" "deny_insecure_transport" {
  count = var.enable_policy && var.attach_deny_insecure_transport_policy ? 1 : 0
  statement {
    sid    = "DenyInsecureTransport"
    effect = "Deny"
    actions = [
      "s3:*",
    ]
    resources = [
      aws_s3_bucket.this[0].arn,
      "${aws_s3_bucket.this[0].arn}/*",
    ]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values = [
        "false"
      ]
    }
  }
}

data "aws_iam_policy_document" "require_latest_tls" {
  count = var.enable_policy && var.attach_require_latest_tls_policy ? 1 : 0
  statement {
    sid    = "DenyOutdatedTLS"
    effect = "Deny"
    actions = [
      "s3:*",
    ]
    resources = [
      aws_s3_bucket.this[0].arn,
      "${aws_s3_bucket.this[0].arn}/*",
    ]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    condition {
      test     = "NumericLessThan"
      variable = "s3:TlsVersion"
      values = [
        "1.2"
      ]
    }
  }
}

data "aws_iam_policy_document" "inventory_destination_policy" {
  count = var.enable && var.attach_inventory_destination_policy ? 1 : 0
  statement {
    sid    = "DestinationInventoryPolicy"
    effect = "Allow"
    actions = [
      "s3:PutObject",
    ]
    resources = [
      "${aws_s3_bucket.this[0].arn}/*",
    ]
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }
    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values = [
        coalesce(var.inventory_source_bucket_arn, aws_s3_bucket.this[0].arn)
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values = [
        coalesce(var.inventory_source_account_id, local.account_id)
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

data "aws_iam_policy_document" "this" {
  count = var.enable && var.enable_policy && local.attach_policy ? 1 : 0
  source_policy_documents = compact([
    var.attach_deny_insecure_transport_policy ? data.aws_iam_policy_document.deny_insecure_transport[0].json : null,
    var.attach_inventory_destination_policy ? data.aws_iam_policy_document.inventory_destination_policy[0].json : null,
    var.attach_require_latest_tls_policy ? data.aws_iam_policy_document.require_latest_tls[0].json : null,
    var.policy != null ? var.policy : null
  ])
}

resource "aws_s3_bucket_policy" "this" {
  count  = var.enable && var.enable_policy ? 1 : 0
  bucket = aws_s3_bucket.this[0].id
  policy = data.aws_iam_policy_document.this[0].json
}

#--------------------------------------------------------------
# S3 Bucket Public Access Block
#--------------------------------------------------------------

resource "aws_s3_bucket_public_access_block" "this" {
  count                   = var.enable && var.enable_public_access_block ? 1 : 0
  bucket                  = aws_s3_bucket.this[0].id
  block_public_acls       = var.public_access_block_block_public_acls
  block_public_policy     = var.public_access_block_block_public_policy
  ignore_public_acls      = var.public_access_block_ignore_public_acls
  restrict_public_buckets = var.public_access_block_restrict_public_buckets
}

#--------------------------------------------------------------
# S3 Bucket Ownership Controls
#--------------------------------------------------------------

resource "aws_s3_bucket_ownership_controls" "this" {
  count  = var.enable && var.enable_ownership_controls ? 1 : 0
  bucket = aws_s3_bucket.this[0].id
  rule {
    object_ownership = var.ownership_rule_object_ownership
  }
}

#--------------------------------------------------------------
# S3 Bucket Intelligent Tiering Configuration
#--------------------------------------------------------------

resource "aws_s3_bucket_intelligent_tiering_configuration" "this" {
  for_each = { for k, v in var.intelligent_tiering_configuration : k => v if var.enable && var.enable_intelligent_tiering_configuration }
  bucket   = aws_s3_bucket.this[0].id
  name     = each.key
  status   = each.value.status
  dynamic "filter" {
    for_each = lookup(each.value, "filter", [])
    content {
      prefix = lookup(filter.value, "prefix", null)
      tags   = lookup(filter.value, "tags", null)
    }
  }
  dynamic "tiering" {
    for_each = each.value.tiering
    content {
      access_tier = tiering.value.access_tier
      days        = tiering.value.days
    }
  }
}

#--------------------------------------------------------------
# S3 Bucket Metric
#--------------------------------------------------------------

resource "aws_s3_bucket_metric" "this" {
  for_each = { for k, v in var.metric_configuration : k => v if var.enable && var.enable_metric }
  bucket   = aws_s3_bucket.this[0].id
  name     = each.key
  dynamic "filter" {
    for_each = lookup(each.value, "filter", [])
    content {
      prefix = lookup(filter.value, "prefix", null)
      tags   = lookup(filter.value, "tags", null)
    }
  }
}

#--------------------------------------------------------------
# S3 Bucket Inventory
#--------------------------------------------------------------

resource "aws_s3_bucket_inventory" "this" {
  for_each                 = { for k, v in var.inventory_configuration : k => v if var.enable && var.enable_inventory }
  bucket                   = aws_s3_bucket.this[0].id
  name                     = each.key
  included_object_versions = each.value.included_object_versions
  enabled                  = each.value.enabled
  optional_fields          = each.value.optional_fields
  schedule {
    frequency = each.value.schedule.frequency
  }
  destination {
    bucket {
      bucket_arn = each.value.destination.bucket.bucket_arn
      format     = each.value.destination.bucket.format
      account_id = each.value.destination.bucket.account_id
      prefix     = each.value.destination.bucket.prefix
      dynamic "encryption" {
        for_each = lookup(each.value.destination.bucket, "encryption", [])
        content {
          dynamic "sse_s3" {
            for_each = lookup(encryption.value, "sse_s3", [])
            content {
            }
          }
          dynamic "sse_kms" {
            for_each = lookup(encryption.value, "sse_kms", [])
            content {
              key_id = sse_kms.value.sse_kms
            }
          }
        }
      }
    }
  }
  dynamic "filter" {
    for_each = each.value.filter
    content {
      prefix = lookup(filter.value, "prefix", null)
    }
  }
}
