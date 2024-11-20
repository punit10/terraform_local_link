# local value tags
locals {
  common_tags = {
    company = var.company
    # interpolation used below
    project      = "${var.company}-${var.project}"
    billing_code = var.billing_code
  }

  s3_bucket_name = "local-link-app-${random_integer.s3.result}"
}

# It wll add a random number while creating s3
resource "random_integer" "s3" {
  min = 10000
  max = 99999
}