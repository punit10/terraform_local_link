# local value tags
locals {
  common_tags = {
    company = var.company
    # interpolation used below
    project      = "${var.company}-${var.project}"
    billing_code = var.billing_code
  }
}