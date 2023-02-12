#--------------------------------------------------------------
# S3 Buckwet
#--------------------------------------------------------------

variable "enable_bucket" {
  type        = bool
  default     = true
  description = "(Optional) Enable S3 Bucket resource creation. Defaults to true."
}

variable "bucket_name" {
  type        = string
  default     = null
  description = "(Optional, Forces new resource) The name of the bucket. If omitted, Terraform will assign a random, unique name. Must be lowercase and less than or equal to 63 characters in length."
}

variable "bucket_prefix" {
  type        = string
  default     = null
  description = "(Optional, Forces new resource) Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket. Must be lowercase and less than or equal to 37 characters in length."
}

variable "bucket_force_destroy" {
  type        = string
  default     = null
  description = "(Optional, Default:false) A boolean that indicates all objects (including any locked objects) should be deleted from the bucket when the bucket is destroyed so that the bucket can be destroyed without error. These objects are not recoverable. This only deletes objects when the bucket is destroyed, not when setting this parameter to true."
}

variable "bucket_object_lock_enabled" {
  type        = string
  default     = null
  description = "(Optional, Forces new resource) Indicates whether this bucket has an Object Lock configuration enabled. Valid values are true or false. This argument is not supported in all regions or partitions."
}

variable "bucket_tags" {
  type        = map(string)
  default     = null
  description = "(Optional) A map of tags to assign to the bucket. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
}

#--------------------------------------------------------------
# S3 Bucket Logging
#--------------------------------------------------------------

variable "enable_logging" {
  type        = bool
  default     = false
  description = "(Optional) Enable S3 Logging resource creation. Defaults to false."
}

variable "logging_expected_bucket_owner" {
  type        = string
  default     = null
  description = "(Optional, Forces new resource) The account ID of the expected bucket owner."
}

variable "logging_target_bucket" {
  type        = string
  default     = null
  description = "(Required) The name of the bucket where you want Amazon S3 to store server access logs."
}

variable "logging_target_prefix" {
  type        = string
  default     = null
  description = "(Required) A prefix for all log object keys."
}

variable "logging_target_grant" {
  type        = any
  default     = []
  description = "(Optional) Set of configuration blocks with information for granting permissions."
}

#--------------------------------------------------------------
# S3 Bucket ACL
#--------------------------------------------------------------

variable "enable_acl" {
  type        = bool
  default     = false
  description = "(Optional) Enable S3 ACL resource creation. Defaults to false."
}

variable "acl" {
  type        = string
  default     = null
  description = "(Optional, Conflicts with access_control_policy) The canned ACL to apply to the bucket."
}

variable "acl_access_control_policy" {
  type        = any
  default     = []
  description = "(Optional, Conflicts with acl) A configuration block that sets the ACL permissions for an object per grantee."
}

variable "acl_expected_bucket_owner" {
  type        = string
  default     = null
  description = "(Optional, Forces new resource) The account ID of the expected bucket owner."
}

#--------------------------------------------------------------
# S3 Bucket Website Configuration
#--------------------------------------------------------------

variable "enable_website_configuration" {
  type        = bool
  default     = false
  description = "(Optional) Enable S3 Website Configuration resource creation. Defaults to false."
}

variable "website_error_document" {
  type        = any
  default     = []
  description = "(Optional, Conflicts with redirect_all_requests_to) The name of the error document for the website."
}

variable "website_expected_bucket_owner" {
  type        = string
  default     = null
  description = "(Optional, Forces new resource) The account ID of the expected bucket owner."
}
variable "website_index_document" {
  type        = any
  default     = []
  description = "(Optional, Required if redirect_all_requests_to is not specified) The name of the index document for the website."
}

variable "website_redirect_all_requests_to" {
  type        = any
  default     = []
  description = "(Optional, Required if index_document is not specified) The redirect behavior for every request to this bucket's website endpoint. Conflicts with error_document, index_document, and routing_rule."
}

variable "website_routing_rule" {
  type        = any
  default     = []
  description = "Optional, Conflicts with redirect_all_requests_to and routing_rules) List of rules that define when a redirect is applied and the redirect behavior."
}

variable "website_routing_rules" {
  type        = string
  default     = null
  description = "(Optional, Conflicts with routing_rule and redirect_all_requests_to) A json array containing routing rules describing redirect behavior and when redirects are applied. Use this parameter when your routing rules contain empty String values ('')."
}

#--------------------------------------------------------------
# S3 Bucket Versioning
#--------------------------------------------------------------

variable "enable_versioning" {
  type        = bool
  default     = false
  description = "(Optional) Enable S3 Versioning resource creation. Defaults to false."
}

variable "versioning_configuration" {
  type        = any
  default     = []
  description = "(Required) Configuration block for the versioning parameters"
}

variable "versioning_expected_bucket_owner" {
  type        = string
  default     = null
  description = "(Optional, Forces new resource) The account ID of the expected bucket owner."
}

variable "versioning_mfa" {
  type        = string
  default     = null
  description = "(Optional, Required if versioning_configuration mfa_delete is enabled) The concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device."
}

#--------------------------------------------------------------
# S3 Bucket Server Side Encryption Configuration
#--------------------------------------------------------------

variable "enable_server_side_encryption_configuration" {
  type        = bool
  default     = false
  description = "(Optional) Enable S3 Server Side Encryption resource creation. Defaults to false."
}

variable "encryption_expected_bucket_owner" {
  type        = string
  default     = null
  description = "(Optional, Forces new resource) The account ID of the expected bucket owner."
}

variable "encryption_rule" {
  type        = any
  default     = []
  description = "(Required) Set of server-side encryption configuration rules. documented below. Currently, only a single rule is supported."
}

#--------------------------------------------------------------
# S3 Bucket Accelerate Configuration 
#--------------------------------------------------------------

variable "enable_accelerate_configuration" {
  type        = bool
  default     = false
  description = "(Optional) Enable S3 Accelerate resource creation. Defaults to false."
}

variable "accelerate_expected_bucket_owner" {
  type        = string
  default     = null
  description = "(Optional, Forces new resource) The account ID of the expected bucket owner."
}

variable "accelerate_status" {
  type        = string
  default     = null
  description = "(Required) The transfer acceleration state of the bucket. Valid values: Enabled, Suspended."
}

#--------------------------------------------------------------
# S3 Bucket Request Payment Configuration
#--------------------------------------------------------------

variable "enable_request_payment_configuration" {
  type        = bool
  default     = false
  description = "(Optional) Enable S3 Request Payment resource creation. Defaults to false."
}

variable "request_payment_expected_bucket_owner" {
  type        = string
  default     = null
  description = "(Optional, Forces new resource) The account ID of the expected bucket owner."
}

variable "request_payment_payer" {
  type        = string
  default     = null
  description = "(Required) Specifies who pays for the download and request fees. Valid values: BucketOwner, Requester."
}

#--------------------------------------------------------------
# S3 Bucket CORS Configuration
#--------------------------------------------------------------

variable "enable_cors_configuration" {
  type        = bool
  default     = false
  description = "(Optional) Enable S3 CORS resource creation. Defaults to false."
}

variable "cors_expected_bucket_owner" {
  type        = string
  default     = null
  description = "(Optional, Forces new resource) The account ID of the expected bucket owner."
}

variable "cors_rule" {
  type        = any
  default     = {}
  description = "(Required) Set of origins and methods (cross-origin access that you want to allow). You can configure up to 100 rules."
}

#--------------------------------------------------------------
# S3 Bucket Lifecycle Configuration
#--------------------------------------------------------------

variable "enable_lifecycle_configuration" {
  type        = bool
  default     = false
  description = "(Optional) Enable S3 Lifecycle resource creation. Defaults to false."
}

variable "lifecycle_expected_bucket_owner" {
  type        = string
  default     = null
  description = "(Optional) The account ID of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP 403 (Access Denied) error."
}

variable "lifecycle_rule" {
  type        = any
  default     = []
  description = "(Required) List of configuration blocks describing the rules managing the replication."
}

#--------------------------------------------------------------
# S3 Bucket Object Lock Configuration
#--------------------------------------------------------------

variable "enable_object_lock_configuration" {
  type        = bool
  default     = false
  description = "(Optional) Enable S3 Object Lock resource creation. Defaults to false."
}

variable "object_lock_expected_bucket_owner" {
  type        = string
  default     = null
  description = "(Optional, Forces new resource) The account ID of the expected bucket owner."
}

variable "object_lock_object_lock_enabled" {
  type        = string
  default     = null
  description = "(Optional, Forces new resource) Indicates whether this bucket has an Object Lock configuration enabled. Defaults to Enabled. Valid values: Enabled."
}

variable "object_lock_rule" {
  type        = any
  default     = []
  description = "(Optional) Configuration block for specifying the Object Lock rule for the specified object."
}

variable "object_lock_token" {
  type        = string
  default     = null
  description = "(Optional) A token to allow Object Lock to be enabled for an existing bucket. You must contact AWS support for the bucket's 'Object Lock token'. The token is generated in the back-end when versioning is enabled on a bucket."
}

#--------------------------------------------------------------
# S3 Bucket Replication Configuration
#--------------------------------------------------------------

variable "enable_replication_configuration" {
  type        = bool
  default     = false
  description = "(Optional) Enable S3 Replication resource creation. Defaults to false."
}

variable "replication_role" {
  type        = string
  default     = null
  description = "(Required) The ARN of the IAM role for Amazon S3 to assume when replicating the objects."
}

variable "replication_rule" {
  type        = any
  default     = []
  description = "(Required) List of configuration blocks describing the rules managing the replication."
}

variable "replication_token" {
  type        = string
  default     = null
  description = "(Optional) A token to allow replication to be enabled on an Object Lock-enabled bucket. You must contact AWS support for the bucket's 'Object Lock token'."
}

#--------------------------------------------------------------
# S3 Bucket Policy
#--------------------------------------------------------------

variable "enable_policy" {
  type        = bool
  default     = false
  description = "(Optional) Enable S3 Policy resource creation. Defaults to false."
}

variable "policy" {
  type        = string
  default     = null
  description = "(Required) The text of the policy. Although this is a bucket policy rather than an IAM policy, the aws_iam_policy_document data source may be used, so long as it specifies a principal. For more information about building AWS IAM policy documents with Terraform. Note: Bucket policies are limited to 20 KB in size."
}

variable "attach_deny_insecure_transport_policy" {
  type        = bool
  default     = false
  description = "(Optional) Enable deny non-SSL transport bucket policy attachment. Defaults to false."
}

variable "attach_require_latest_tls_policy" {
  type        = bool
  default     = false
  description = "(Optional) Enable require latest version of TLS bucket policy attachment. Defaults to false."
}

variable "attach_inventory_destination_policy" {
  type        = bool
  default     = false
  description = "(Optional) Enable inventory destination bucket policy attachment. Defaults to false."
}

variable "inventory_source_account_id" {
  type        = string
  default     = null
  description = "(Optional) Inventory policy source account id."
}

variable "inventory_source_bucket_arn" {
  type        = string
  default     = null
  description = "(Optional) Inventory policy source bucket ARN."
}

#--------------------------------------------------------------
# S3 Bucket Public Access Block
#--------------------------------------------------------------

variable "enable_public_access_block" {
  type        = bool
  default     = false
  description = "(Optional) Enable S3 Public Access Block resource creation. Defaults to false."
}

variable "public_access_block_block_public_acls" {
  type        = bool
  default     = null
  description = "Optional) Whether Amazon S3 should block public ACLs for this bucket. Defaults to false. Enabling this setting does not affect existing policies or ACLs. When set to true PUT Bucket acl and PUT Object acl calls will fail if the specified ACL allows public access and PUT Object calls will fail if the request includes an object ACL."
}

variable "public_access_block_block_public_policy" {
  type        = bool
  default     = null
  description = "(Optional) Whether Amazon S3 should block public bucket policies for this bucket. Defaults to false. Enabling this setting does not affect the existing bucket policy. When set to true causes Amazon S3 to reject calls to PUT Bucket policy if the specified bucket policy allows public access."
}

variable "public_access_block_ignore_public_acls" {
  type        = bool
  default     = null
  description = "Optional) Whether Amazon S3 should ignore public ACLs for this bucket. Defaults to false. Enabling this setting does not affect the persistence of any existing ACLs and doesn't prevent new public ACLs from being set. When set to true causes Amazon S3 to ignore public ACLs on this bucket and any objects that it contains."
}

variable "public_access_block_restrict_public_buckets" {
  type        = bool
  default     = null
  description = "(Optional) Whether Amazon S3 should restrict public bucket policies for this bucket. Defaults to false. Enabling this setting does not affect the previously stored bucket policy, except that public and cross-account access within the public bucket policy, including non-public delegation to specific accounts, is blocked. When set to true only the bucket owner and AWS Services can access this buckets if it has a public policy."
}

#--------------------------------------------------------------
# S3 Bucket Ownership Controls
#--------------------------------------------------------------

variable "enable_ownership_controls" {
  type        = bool
  default     = false
  description = "(Optional) Enable S3 Ownership Controls resource creation. Defaults to false."
}

variable "ownership_rule" {
  type        = any
  default     = []
  description = "Required) Configuration block(s) with Ownership Controls rules."
}

#--------------------------------------------------------------
# S3 Bucket Intelligent Tiering Configuration
#--------------------------------------------------------------

variable "enable_intelligent_tiering_configuration" {
  type        = bool
  default     = false
  description = "(Optional) Enable S3 Intelligent Tiering resource creation. Defaults to false."
}

variable "intelligent_tiering_configuration" {
  type        = any
  default     = {}
  description = "(Required) Maps of intelligent tiering configuration blocks."
}

# variable "intelligent_tiering_name" {
#   type        = string
#   default     = null
#   description = "(Required) The unique name used to identify the S3 Intelligent-Tiering configuration for the bucket."
# }
# 
# variable "intelligent_tiering_status" {
#   type        = string
#   default     = null
#   description = "(Optional) Specifies the status of the configuration. Valid values: Enabled, Disabled."
# }
# 
# variable "intelligent_tiering_filter" {
#   type        = any
#   default     = []
#   description = "(Optional) A bucket filter. The configuration only includes objects that meet the filter's criteria."
# }
# 
# variable "intelligent_tiering_access_tier" {
#   type        = string
#   default     = null
#   description = "(Required) S3 Intelligent-Tiering access tier. Valid values: ARCHIVE_ACCESS, DEEP_ARCHIVE_ACCESS."
# }
# 
# variable "intelligent_tiering_days" {
#   type        = number
#   default     = null
#   description = "(Required) The number of consecutive days of no access after which an object will be eligible to be transitioned to the corresponding tier."
# }

#--------------------------------------------------------------
# S3 Bucket Metric
#--------------------------------------------------------------

variable "enable_metric" {
  type        = bool
  default     = false
  description = "(Optional) Enable S3 Metric resource creation. Defaults to false."
}

variable "metric_configuration" {
  type        = any
  default     = {}
  description = "(Required) Maps of metric configuration blocks."
}

# variable "metric_name" {
#   type        = string
#   default     = null
#   description = "(Optional) Object filtering that accepts a prefix, tags, or a logical AND of prefix and tags."
# }
# 
# variable "metric_filter" {
#   type        = any
#   default     = []
#   description = "(Optional) Object filtering that accepts a prefix, tags, or a logical AND of prefix and tags."
# }

#--------------------------------------------------------------
# S3 Bucket Inventory
#--------------------------------------------------------------

variable "enable_inventory" {
  type        = bool
  default     = false
  description = "(Optional) Enable S3 Inventory resource creation. Defaults to false."
}

variable "inventory_configuration" {
  type        = any
  default     = {}
  description = "(Required) Maps of inventoryconfiguration blocks."
}

# variable "inventory_name" {
#   type        = string
#   default     = null
#   description = "(Required) Unique identifier of the inventory configuration for the bucket."
# }
# 
# variable "inventory_included_object_versions" {
#   type        = string
#   default     = null
#   description = "(Required) Object versions to include in the inventory list. Valid values: All, Current."
# }
# 
# variable "inventory_schedule" {
#   type        = any
#   default     = []
#   description = "(Required) Specifies the schedule for generating inventory results."
# }
# 
# variable "inventory_destination" {
#   type        = any
#   default     = []
#   description = "(Required) Contains information about where to publish the inventory results."
# }
# 
# variable "inventory_enabled" {
#   type        = bool
#   default     = null
#   description = "(Optional, Default: true) Specifies whether the inventory is enabled or disabled."
# }
# 
# variable "inventory_filter" {
#   type        = any
#   default     = []
#   description = "(Optional) Specifies an inventory filter. The inventory only includes objects that meet the filter's criteria."
# }
# 
# variable "inventory_optional_fields" {
#   type        = list(string)
#   default     = null
#   description = "(Optional) List of optional fields that are included in the inventory results. Please refer to the S3 documentation for more details."
# }
