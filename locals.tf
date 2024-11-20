# local value tags
locals {
  common_tags = {
    company = var.company
    # interpolation used below
    project      = "${var.company}-${var.project}"
    billing_code = var.billing_code
    environment  = var.environment
  }

  s3_bucket_name = "${lower(local.naming_prefix)}-${random_integer.s3.result}"

  website_content = {
    website = "/website/index.html"
    logo    = "/website/Globo_logo_Vert.png"
  }

  naming_prefix = "${var.naming_prefix}-${var.environment}"

}

# It wll add a random number while creating s3
resource "random_integer" "s3" {
  min = 10000
  max = 99999
}