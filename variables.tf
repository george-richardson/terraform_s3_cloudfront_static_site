variable "name" {
  type        = "string"
  description = "The fqdn to be used for the site. Must be available within the given hosted zone."
}

variable "hosted_zone_id" {
  type        = "string"
  description = "The id of the route 53 hosted zone to use for DNS records."
}

variable "region" {
  type        = "string"
  description = "The S3 region to create the bucket in."
  default     = "us-east-1"
}

variable "tags" {
  type        = "map"
  description = "Tags to add to any resources that support them."
  default     = {}
}

variable "default_root_object" {
  type        = "string"
  description = "The default root object to serve through the cloudfront distibution. e.g. index.html"
  default     = "index.html"
}

variable "error_404_object" {
  type        = "string"
  description = "The object to serve when there is a 404 not found. e.g. /404.html. Note this requires a '/' prefix."
  default     = "/404.html"
}
