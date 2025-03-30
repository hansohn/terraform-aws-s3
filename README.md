<div align="center">
  <h3>terraform-aws-s3</h3>
  <p>Another Terraform AWS Module Template Repository</p>
  <p>
    <!-- Build Status -->
    <a href="https://actions-badge.atrox.dev/hansohn/terraform-aws-s3/goto?ref=main">
      <img src="https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Fhansohn%2Fterraform-aws-s3%2Fbadge%3Fref%3Dmain&style=for-the-badge">
    </a>
    <!-- Github Tag -->
    <a href="https://gitHub.com/hansohn/terraform-aws-s3/tags/">
      <img src="https://img.shields.io/github/tag/hansohn/terraform-aws-s3.svg?style=for-the-badge">
    </a>
    <!-- License -->
    <a href="https://github.com/hansohn/terraform-aws-s3/blob/main/LICENSE">
      <img src="https://img.shields.io/github/license/hansohn/terraform-aws-s3.svg?style=for-the-badge">
    </a>
    <!-- LinkedIn -->
    <a href="https://linkedin.com/in/ryanhansohn">
      <img src="https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555">
    </a>
  </p>
</div>

## Usage

Welcome to the terraform-aws-s3 repo!

## Examples

Please see the sample set of examples below for a better understanding of implementation

- [Complete](examples/complete) - Complete Example

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_accelerate_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_accelerate_configuration) | resource |
| [aws_s3_bucket_acl.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_cors_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_cors_configuration) | resource |
| [aws_s3_bucket_intelligent_tiering_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_intelligent_tiering_configuration) | resource |
| [aws_s3_bucket_inventory.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_inventory) | resource |
| [aws_s3_bucket_lifecycle_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_logging.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_metric.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_metric) | resource |
| [aws_s3_bucket_object_lock_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object_lock_configuration) | resource |
| [aws_s3_bucket_ownership_controls.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_replication_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_replication_configuration) | resource |
| [aws_s3_bucket_request_payment_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_request_payment_configuration) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_website_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.deny_insecure_transport](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.inventory_destination_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.require_latest_tls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accelerate_expected_bucket_owner"></a> [accelerate\_expected\_bucket\_owner](#input\_accelerate\_expected\_bucket\_owner) | (Optional, Forces new resource) The account ID of the expected bucket owner. | `string` | `null` | no |
| <a name="input_accelerate_status"></a> [accelerate\_status](#input\_accelerate\_status) | (Required) The transfer acceleration state of the bucket. Valid values: Enabled, Suspended. | `string` | `null` | no |
| <a name="input_acl"></a> [acl](#input\_acl) | (Optional, Conflicts with access\_control\_policy) The canned ACL to apply to the bucket. | `string` | `null` | no |
| <a name="input_acl_access_control_policy"></a> [acl\_access\_control\_policy](#input\_acl\_access\_control\_policy) | (Optional, Conflicts with acl) A configuration block that sets the ACL permissions for an object per grantee. | `any` | `[]` | no |
| <a name="input_acl_expected_bucket_owner"></a> [acl\_expected\_bucket\_owner](#input\_acl\_expected\_bucket\_owner) | (Optional, Forces new resource) The account ID of the expected bucket owner. | `string` | `null` | no |
| <a name="input_attach_deny_insecure_transport_policy"></a> [attach\_deny\_insecure\_transport\_policy](#input\_attach\_deny\_insecure\_transport\_policy) | (Optional) Enable deny non-SSL transport bucket policy attachment. Defaults to true. | `bool` | `true` | no |
| <a name="input_attach_inventory_destination_policy"></a> [attach\_inventory\_destination\_policy](#input\_attach\_inventory\_destination\_policy) | (Optional) Enable inventory destination bucket policy attachment. Defaults to false. | `bool` | `false` | no |
| <a name="input_attach_require_latest_tls_policy"></a> [attach\_require\_latest\_tls\_policy](#input\_attach\_require\_latest\_tls\_policy) | (Optional) Enable require latest version of TLS bucket policy attachment. Defaults to true. | `bool` | `true` | no |
| <a name="input_bucket"></a> [bucket](#input\_bucket) | (Optional, Forces new resource) The name of the bucket. If omitted, Terraform will assign a random, unique name. Must be lowercase and less than or equal to 63 characters in length. | `string` | `null` | no |
| <a name="input_bucket_prefix"></a> [bucket\_prefix](#input\_bucket\_prefix) | (Optional, Forces new resource) Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket. Must be lowercase and less than or equal to 37 characters in length. | `string` | `null` | no |
| <a name="input_cors_expected_bucket_owner"></a> [cors\_expected\_bucket\_owner](#input\_cors\_expected\_bucket\_owner) | (Optional, Forces new resource) The account ID of the expected bucket owner. | `string` | `null` | no |
| <a name="input_cors_rule"></a> [cors\_rule](#input\_cors\_rule) | (Required) Set of origins and methods (cross-origin access that you want to allow). You can configure up to 100 rules. | `any` | `{}` | no |
| <a name="input_enable"></a> [enable](#input\_enable) | (Optional) Enable S3 Bucket resource creation. Defaults to true. | `bool` | `true` | no |
| <a name="input_enable_accelerate_configuration"></a> [enable\_accelerate\_configuration](#input\_enable\_accelerate\_configuration) | (Optional) Enable S3 Accelerate resource creation. Defaults to false. | `bool` | `false` | no |
| <a name="input_enable_acl"></a> [enable\_acl](#input\_enable\_acl) | (Optional) Enable S3 ACL resource creation. Defaults to false. | `bool` | `false` | no |
| <a name="input_enable_cors_configuration"></a> [enable\_cors\_configuration](#input\_enable\_cors\_configuration) | (Optional) Enable S3 CORS resource creation. Defaults to false. | `bool` | `false` | no |
| <a name="input_enable_intelligent_tiering_configuration"></a> [enable\_intelligent\_tiering\_configuration](#input\_enable\_intelligent\_tiering\_configuration) | (Optional) Enable S3 Intelligent Tiering resource creation. Defaults to false. | `bool` | `false` | no |
| <a name="input_enable_inventory"></a> [enable\_inventory](#input\_enable\_inventory) | (Optional) Enable S3 Inventory resource creation. Defaults to false. | `bool` | `false` | no |
| <a name="input_enable_lifecycle_configuration"></a> [enable\_lifecycle\_configuration](#input\_enable\_lifecycle\_configuration) | (Optional) Enable S3 Lifecycle resource creation. Defaults to false. | `bool` | `false` | no |
| <a name="input_enable_logging"></a> [enable\_logging](#input\_enable\_logging) | (Optional) Enable S3 Logging resource creation. Defaults to false. | `bool` | `false` | no |
| <a name="input_enable_metric"></a> [enable\_metric](#input\_enable\_metric) | (Optional) Enable S3 Metric resource creation. Defaults to false. | `bool` | `false` | no |
| <a name="input_enable_object_lock_configuration"></a> [enable\_object\_lock\_configuration](#input\_enable\_object\_lock\_configuration) | (Optional) Enable S3 Object Lock resource creation. Defaults to false. | `bool` | `false` | no |
| <a name="input_enable_ownership_controls"></a> [enable\_ownership\_controls](#input\_enable\_ownership\_controls) | (Optional) Enable S3 Ownership Controls resource creation. Defaults to true. | `bool` | `true` | no |
| <a name="input_enable_policy"></a> [enable\_policy](#input\_enable\_policy) | (Optional) Enable S3 Policy resource creation. Defaults to true. | `bool` | `true` | no |
| <a name="input_enable_public_access_block"></a> [enable\_public\_access\_block](#input\_enable\_public\_access\_block) | (Optional) Enable S3 Public Access Block resource creation. Defaults to true. | `bool` | `true` | no |
| <a name="input_enable_replication_configuration"></a> [enable\_replication\_configuration](#input\_enable\_replication\_configuration) | (Optional) Enable S3 Replication resource creation. Defaults to false. | `bool` | `false` | no |
| <a name="input_enable_request_payment_configuration"></a> [enable\_request\_payment\_configuration](#input\_enable\_request\_payment\_configuration) | (Optional) Enable S3 Request Payment resource creation. Defaults to false. | `bool` | `false` | no |
| <a name="input_enable_server_side_encryption_configuration"></a> [enable\_server\_side\_encryption\_configuration](#input\_enable\_server\_side\_encryption\_configuration) | (Optional) Enable S3 Server Side Encryption resource creation. Defaults to true. | `bool` | `true` | no |
| <a name="input_enable_versioning"></a> [enable\_versioning](#input\_enable\_versioning) | (Optional) Enable S3 Versioning resource creation. Defaults to false. | `bool` | `false` | no |
| <a name="input_enable_website_configuration"></a> [enable\_website\_configuration](#input\_enable\_website\_configuration) | (Optional) Enable S3 Website Configuration resource creation. Defaults to false. | `bool` | `false` | no |
| <a name="input_encryption_bucket_key_enabled"></a> [encryption\_bucket\_key\_enabled](#input\_encryption\_bucket\_key\_enabled) | (Optional) Whether or not to use Amazon S3 Bucket Keys for SSE-KMS. | `string` | `null` | no |
| <a name="input_encryption_expected_bucket_owner"></a> [encryption\_expected\_bucket\_owner](#input\_encryption\_expected\_bucket\_owner) | (Optional, Forces new resource) The account ID of the expected bucket owner. | `string` | `null` | no |
| <a name="input_encryption_kms_master_key_id"></a> [encryption\_kms\_master\_key\_id](#input\_encryption\_kms\_master\_key\_id) | (Optional) AWS KMS master key ID used for the SSE-KMS encryption. This can only be used when you set the value of sse\_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse\_algorithm is aws:kms. | `string` | `null` | no |
| <a name="input_encryption_sse_algorithm"></a> [encryption\_sse\_algorithm](#input\_encryption\_sse\_algorithm) | (Required) Server-side encryption algorithm to use. Valid values are AES256, aws:kms, and aws:kms:dsse. Default to 'AES256' | `string` | `"AES256"` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | (Optional, Default:false) A boolean that indicates all objects (including any locked objects) should be deleted from the bucket when the bucket is destroyed so that the bucket can be destroyed without error. These objects are not recoverable. This only deletes objects when the bucket is destroyed, not when setting this parameter to true. | `string` | `null` | no |
| <a name="input_intelligent_tiering_configuration"></a> [intelligent\_tiering\_configuration](#input\_intelligent\_tiering\_configuration) | (Required) Maps of intelligent tiering configuration blocks. | `any` | `{}` | no |
| <a name="input_inventory_configuration"></a> [inventory\_configuration](#input\_inventory\_configuration) | (Required) Maps of inventoryconfiguration blocks. | `any` | `{}` | no |
| <a name="input_inventory_source_account_id"></a> [inventory\_source\_account\_id](#input\_inventory\_source\_account\_id) | (Optional) Inventory policy source account id. | `string` | `null` | no |
| <a name="input_inventory_source_bucket_arn"></a> [inventory\_source\_bucket\_arn](#input\_inventory\_source\_bucket\_arn) | (Optional) Inventory policy source bucket ARN. | `string` | `null` | no |
| <a name="input_lifecycle_expected_bucket_owner"></a> [lifecycle\_expected\_bucket\_owner](#input\_lifecycle\_expected\_bucket\_owner) | (Optional) The account ID of the expected bucket owner. If the bucket is owned by a different account, the request will fail with an HTTP 403 (Access Denied) error. | `string` | `null` | no |
| <a name="input_lifecycle_rule"></a> [lifecycle\_rule](#input\_lifecycle\_rule) | (Required) List of configuration blocks describing the rules managing the replication. | `any` | `[]` | no |
| <a name="input_logging_expected_bucket_owner"></a> [logging\_expected\_bucket\_owner](#input\_logging\_expected\_bucket\_owner) | (Optional, Forces new resource) The account ID of the expected bucket owner. | `string` | `null` | no |
| <a name="input_logging_target_bucket"></a> [logging\_target\_bucket](#input\_logging\_target\_bucket) | (Required) The name of the bucket where you want Amazon S3 to store server access logs. | `string` | `null` | no |
| <a name="input_logging_target_grant"></a> [logging\_target\_grant](#input\_logging\_target\_grant) | (Optional) Set of configuration blocks with information for granting permissions. | `any` | `[]` | no |
| <a name="input_logging_target_prefix"></a> [logging\_target\_prefix](#input\_logging\_target\_prefix) | (Required) A prefix for all log object keys. | `string` | `null` | no |
| <a name="input_metric_configuration"></a> [metric\_configuration](#input\_metric\_configuration) | (Required) Maps of metric configuration blocks. | `any` | `{}` | no |
| <a name="input_object_lock_enabled"></a> [object\_lock\_enabled](#input\_object\_lock\_enabled) | (Optional, Forces new resource) Indicates whether this bucket has an Object Lock configuration enabled. Valid values are true or false. This argument is not supported in all regions or partitions. | `string` | `null` | no |
| <a name="input_object_lock_expected_bucket_owner"></a> [object\_lock\_expected\_bucket\_owner](#input\_object\_lock\_expected\_bucket\_owner) | (Optional, Forces new resource) The account ID of the expected bucket owner. | `string` | `null` | no |
| <a name="input_object_lock_object_lock_enabled"></a> [object\_lock\_object\_lock\_enabled](#input\_object\_lock\_object\_lock\_enabled) | (Optional, Forces new resource) Indicates whether this bucket has an Object Lock configuration enabled. Defaults to Enabled. Valid values: Enabled. | `string` | `null` | no |
| <a name="input_object_lock_rule"></a> [object\_lock\_rule](#input\_object\_lock\_rule) | (Optional) Configuration block for specifying the Object Lock rule for the specified object. | `any` | `[]` | no |
| <a name="input_object_lock_token"></a> [object\_lock\_token](#input\_object\_lock\_token) | (Optional) A token to allow Object Lock to be enabled for an existing bucket. You must contact AWS support for the bucket's 'Object Lock token'. The token is generated in the back-end when versioning is enabled on a bucket. | `string` | `null` | no |
| <a name="input_ownership_rule_object_ownership"></a> [ownership\_rule\_object\_ownership](#input\_ownership\_rule\_object\_ownership) | (Required) Object ownership. Valid values: BucketOwnerPreferred, ObjectWriter or BucketOwnerEnforced. Defaults to 'BucketOwnerEnforced' | `string` | `"BucketOwnerEnforced"` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | (Required) The text of the policy. Although this is a bucket policy rather than an IAM policy, the aws\_iam\_policy\_document data source may be used, so long as it specifies a principal. For more information about building AWS IAM policy documents with Terraform. Note: Bucket policies are limited to 20 KB in size. | `string` | `null` | no |
| <a name="input_public_access_block_block_public_acls"></a> [public\_access\_block\_block\_public\_acls](#input\_public\_access\_block\_block\_public\_acls) | Optional) Whether Amazon S3 should block public ACLs for this bucket. Defaults to true. Enabling this setting does not affect existing policies or ACLs. When set to true PUT Bucket acl and PUT Object acl calls will fail if the specified ACL allows public access and PUT Object calls will fail if the request includes an object ACL. | `bool` | `true` | no |
| <a name="input_public_access_block_block_public_policy"></a> [public\_access\_block\_block\_public\_policy](#input\_public\_access\_block\_block\_public\_policy) | (Optional) Whether Amazon S3 should block public bucket policies for this bucket. Defaults to true. Enabling this setting does not affect the existing bucket policy. When set to true causes Amazon S3 to reject calls to PUT Bucket policy if the specified bucket policy allows public access. | `bool` | `true` | no |
| <a name="input_public_access_block_ignore_public_acls"></a> [public\_access\_block\_ignore\_public\_acls](#input\_public\_access\_block\_ignore\_public\_acls) | Optional) Whether Amazon S3 should ignore public ACLs for this bucket. Defaults to true. Enabling this setting does not affect the persistence of any existing ACLs and doesn't prevent new public ACLs from being set. When set to true causes Amazon S3 to ignore public ACLs on this bucket and any objects that it contains. | `bool` | `true` | no |
| <a name="input_public_access_block_restrict_public_buckets"></a> [public\_access\_block\_restrict\_public\_buckets](#input\_public\_access\_block\_restrict\_public\_buckets) | (Optional) Whether Amazon S3 should restrict public bucket policies for this bucket. Defaults to true. Enabling this setting does not affect the previously stored bucket policy, except that public and cross-account access within the public bucket policy, including non-public delegation to specific accounts, is blocked. When set to true only the bucket owner and AWS Services can access this buckets if it has a public policy. | `bool` | `true` | no |
| <a name="input_replication_role"></a> [replication\_role](#input\_replication\_role) | (Required) The ARN of the IAM role for Amazon S3 to assume when replicating the objects. | `string` | `null` | no |
| <a name="input_replication_rule"></a> [replication\_rule](#input\_replication\_rule) | (Required) List of configuration blocks describing the rules managing the replication. | `any` | `[]` | no |
| <a name="input_replication_token"></a> [replication\_token](#input\_replication\_token) | (Optional) A token to allow replication to be enabled on an Object Lock-enabled bucket. You must contact AWS support for the bucket's 'Object Lock token'. | `string` | `null` | no |
| <a name="input_request_payment_expected_bucket_owner"></a> [request\_payment\_expected\_bucket\_owner](#input\_request\_payment\_expected\_bucket\_owner) | (Optional, Forces new resource) The account ID of the expected bucket owner. | `string` | `null` | no |
| <a name="input_request_payment_payer"></a> [request\_payment\_payer](#input\_request\_payment\_payer) | (Required) Specifies who pays for the download and request fees. Valid values: BucketOwner, Requester. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to the bucket. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `null` | no |
| <a name="input_versioning_configuration"></a> [versioning\_configuration](#input\_versioning\_configuration) | (Required) Configuration block for the versioning parameters | `any` | `{}` | no |
| <a name="input_versioning_expected_bucket_owner"></a> [versioning\_expected\_bucket\_owner](#input\_versioning\_expected\_bucket\_owner) | (Optional, Forces new resource) The account ID of the expected bucket owner. | `string` | `null` | no |
| <a name="input_versioning_mfa"></a> [versioning\_mfa](#input\_versioning\_mfa) | (Optional, Required if versioning\_configuration mfa\_delete is enabled) The concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device. | `string` | `null` | no |
| <a name="input_website_error_document"></a> [website\_error\_document](#input\_website\_error\_document) | (Optional, Conflicts with redirect\_all\_requests\_to) The name of the error document for the website. | `any` | `[]` | no |
| <a name="input_website_expected_bucket_owner"></a> [website\_expected\_bucket\_owner](#input\_website\_expected\_bucket\_owner) | (Optional, Forces new resource) The account ID of the expected bucket owner. | `string` | `null` | no |
| <a name="input_website_index_document"></a> [website\_index\_document](#input\_website\_index\_document) | (Optional, Required if redirect\_all\_requests\_to is not specified) The name of the index document for the website. | `any` | `[]` | no |
| <a name="input_website_redirect_all_requests_to"></a> [website\_redirect\_all\_requests\_to](#input\_website\_redirect\_all\_requests\_to) | (Optional, Required if index\_document is not specified) The redirect behavior for every request to this bucket's website endpoint. Conflicts with error\_document, index\_document, and routing\_rule. | `any` | `[]` | no |
| <a name="input_website_routing_rule"></a> [website\_routing\_rule](#input\_website\_routing\_rule) | Optional, Conflicts with redirect\_all\_requests\_to and routing\_rules) List of rules that define when a redirect is applied and the redirect behavior. | `any` | `[]` | no |
| <a name="input_website_routing_rules"></a> [website\_routing\_rules](#input\_website\_routing\_rules) | (Optional, Conflicts with routing\_rule and redirect\_all\_requests\_to) A json array containing routing rules describing redirect behavior and when redirects are applied. Use this parameter when your routing rules contain empty String values (''). | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_accelerate_configuration_id"></a> [accelerate\_configuration\_id](#output\_accelerate\_configuration\_id) | The bucket or bucket and expected\_bucket\_owner separated by a comma (,) if the latter is provided. |
| <a name="output_acl_id"></a> [acl\_id](#output\_acl\_id) | The bucket, expected\_bucket\_owner (if configured), and acl (if configured) separated by commas (,). |
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the bucket. Will be of format arn:aws:s3:::bucketname. |
| <a name="output_bucket_domain_name"></a> [bucket\_domain\_name](#output\_bucket\_domain\_name) | The bucket domain name. Will be of format bucketname.s3.amazonaws.com. |
| <a name="output_bucket_regional_domain_name"></a> [bucket\_regional\_domain\_name](#output\_bucket\_regional\_domain\_name) | The bucket region-specific domain name. The bucket domain name including the region name, please refer here for format. Note: The AWS CloudFront allows specifying S3 region-specific endpoint when creating S3 origin, it will prevent redirect issues from CloudFront to S3 Origin URL. |
| <a name="output_cors_configuration_id"></a> [cors\_configuration\_id](#output\_cors\_configuration\_id) | The bucket or bucket and expected\_bucket\_owner separated by a comma (,) if the latter is provided. |
| <a name="output_hosted_zone_id"></a> [hosted\_zone\_id](#output\_hosted\_zone\_id) | The Route 53 Hosted Zone ID for this bucket's region. |
| <a name="output_id"></a> [id](#output\_id) | The name of the bucket. |
| <a name="output_lifecycle_configuration_id"></a> [lifecycle\_configuration\_id](#output\_lifecycle\_configuration\_id) | The bucket or bucket and expected\_bucket\_owner separated by a comma (,) if the latter is provided. |
| <a name="output_logging_id"></a> [logging\_id](#output\_logging\_id) | The bucket or bucket and expected\_bucket\_owner separated by a comma (,) if the latter is provided. |
| <a name="output_object_lock_configuration_id"></a> [object\_lock\_configuration\_id](#output\_object\_lock\_configuration\_id) | The bucket or bucket and expected\_bucket\_owner separated by a comma (,) if the latter is provided. |
| <a name="output_ownership_controls_id"></a> [ownership\_controls\_id](#output\_ownership\_controls\_id) | S3 Bucket name. |
| <a name="output_policy_bucket"></a> [policy\_bucket](#output\_policy\_bucket) | (Required) The name of the bucket to which to apply the policy. |
| <a name="output_policy_policy"></a> [policy\_policy](#output\_policy\_policy) | (Required) The text of the policy. Although this is a bucket policy rather than an IAM policy, the aws\_iam\_policy\_document data source may be used, so long as it specifies a principal. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide. Note: Bucket policies are limited to 20 KB in size. |
| <a name="output_public_access_block_id"></a> [public\_access\_block\_id](#output\_public\_access\_block\_id) | Name of the S3 bucket the configuration is attached to |
| <a name="output_region"></a> [region](#output\_region) | The AWS region this bucket resides in. |
| <a name="output_replication_configuration_id"></a> [replication\_configuration\_id](#output\_replication\_configuration\_id) | The S3 source bucket name. |
| <a name="output_request_payment_configuration_id"></a> [request\_payment\_configuration\_id](#output\_request\_payment\_configuration\_id) | The bucket or bucket and expected\_bucket\_owner separated by a comma (,) if the latter is provided. |
| <a name="output_server_side_encryption_configuration_id"></a> [server\_side\_encryption\_configuration\_id](#output\_server\_side\_encryption\_configuration\_id) | The bucket or bucket and expected\_bucket\_owner separated by a comma (,) if the latter is provided. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider default\_tags configuration block. |
| <a name="output_versioning_id"></a> [versioning\_id](#output\_versioning\_id) | The bucket or bucket and expected\_bucket\_owner separated by a comma (,) if the latter is provided. |
| <a name="output_website_configuration_id"></a> [website\_configuration\_id](#output\_website\_configuration\_id) | The bucket or bucket and expected\_bucket\_owner separated by a comma (,) if the latter is provided. |
| <a name="output_website_configuration_website_domain"></a> [website\_configuration\_website\_domain](#output\_website\_configuration\_website\_domain) | The domain of the website endpoint. This is used to create Route 53 alias records. |
| <a name="output_website_configuration_website_endpoint"></a> [website\_configuration\_website\_endpoint](#output\_website\_configuration\_website\_endpoint) | The website endpoint. |
| <a name="output_website_domain"></a> [website\_domain](#output\_website\_domain) | The domain of the website endpoint, if the bucket is configured with a website. If not, this will be an empty string. This is used to create Route 53 alias records. |
| <a name="output_website_endpoint"></a> [website\_endpoint](#output\_website\_endpoint) | The website endpoint, if the bucket is configured with a website. If not, this will be an empty string. |
<!-- END_TF_DOCS -->

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
