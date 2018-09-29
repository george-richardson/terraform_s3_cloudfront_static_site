# terraform_s3_cloudfront_static_site

A module for creating static websites hosted in S3 and distributed through cloudfront, perfect for use with site generation tools such as [Jekyll](https://jekyllrb.com/). The site will be given an SSL certificate generated with ACM and a DNS record in Route53.

# Usage

```
module "static_site" {
  source = "git::https://github.com/george-richardson/terraform_s3_cloudfront_static_site.git?ref=1.0.0"

  name           = "test.example.com"
  hosted_zone_id = "${var.hosted_zone_id}"

  tags = {
	  environment = "development"
  }
}
```

# Variables

* `name`  
  The fqdn to be used for the site. Must be available within the given hosted zone. (required)
* `hosted_zone_id`  
  The id of the route 53 hosted zone to use for DNS records. (required)
* `region`  
  The S3 region to create the bucket in.
* `tags`  
  Tags to add to any resources that support them.
* `default_root_object`  
  The default root object to serve through the cloudfront distibution. e.g. index.html

# Outputs

* `bucket_id`  
  The name of the created S3 bucket. Put your files here.
* `distribution_id`  
  The ID of the created distibution. Run invalidations on this when updating your website.
