<!-- BEGIN_TF_DOCS -->
# terraform\_s3\_cloudfront\_static\_site

A module for creating static websites hosted in S3 and distributed through cloudfront, perfect for use with site generation tools such as [Jekyll](https://jekyllrb.com/). The site will be given an SSL certificate generated with ACM and a DNS record in Route53.

# Usage

```
module "static_site" {
  source = "git::https://github.com/george-richardson/terraform_s3_cloudfront_static_site.git?ref=master"

  providers {
    aws.useast1 = aws.useast1
  }

  name           = "test.example.com"
  hosted_zone_id = var.hosted_zone_id
}
```

You need to include the providers block as ACM certificates for cloudfront distributions must be in the US-East-1 region and so needs a different provider that is able to access this region independent of the region chosen for the other resources. More info on using multiple providers for modules can be found in the [terraform documentation](https://www.terraform.io/docs/modules/usage.html#providers-within-modules).

foo

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.9.0 |
| <a name="provider_aws.useast1"></a> [aws.useast1](#provider\_aws.useast1) | >= 4.9.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.certificate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.site_certificate_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_cloudfront_distribution.distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_control.origin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control) | resource |
| [aws_route53_record.a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.certificate_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_s3_bucket.origin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.origin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_iam_policy_document.origin_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_route53_zone.hosted_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Override the name of the bucket that is deployed. | `string` | `""` | no |
| <a name="input_default_root_object"></a> [default\_root\_object](#input\_default\_root\_object) | The default root object to serve through the cloudfront distibution. e.g. index.html | `string` | `"index.html"` | no |
| <a name="input_error_404_object"></a> [error\_404\_object](#input\_error\_404\_object) | The object to serve when there is a 404 not found. e.g. /404.html. Note this requires a '/' prefix. | `string` | `"/404.html"` | no |
| <a name="input_hosted_zone_id"></a> [hosted\_zone\_id](#input\_hosted\_zone\_id) | The id of the route 53 hosted zone to use for DNS records. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The fqdn to be used for the site. Must be available within the given hosted zone. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to any resources that support them. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | n/a |
| <a name="output_distribution_id"></a> [distribution\_id](#output\_distribution\_id) | n/a |
<!-- END_TF_DOCS -->