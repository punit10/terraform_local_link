# Resources related to Istances

data "aws_ssm_parameter" "amzn2_linux" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# INSTANCES #
resource "aws_instance" "nginx_servers" {
  count         = var.ec2_instance_count
  ami           = nonsensitive(data.aws_ssm_parameter.amzn2_linux.value)
  instance_type = var.aws_instance_size.micro

  # now using % so that instances will be evenly distributed to available subnet count 
  subnet_id              = aws_subnet.public_subnets[(count.index % var.vpc_public_subnet_count)].id
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.nginx_profile.name
  depends_on             = [aws_iam_role_policy.allow_s3_all]
  user_data = templatefile(
    "${path.module}/templates/startup_script.tpl", {
      s3_bucket_name = aws_s3_bucket.web_bucket.id
    }
  )
  tags = merge(local.common_tags, { Name = "${local.naming_prefix}-server-${count.index}" })
}


# aws_iam_role.  S3 access for instances
resource "aws_iam_role" "allow_nginx_s3" {
  name = "${local.naming_prefix}-allow_nginx_s3"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = local.common_tags
}

# aws_iam_instance_profile
resource "aws_iam_instance_profile" "nginx_profile" {
  name = "${local.naming_prefix}-nginx_profile"
  role = aws_iam_role.allow_nginx_s3.name

  tags = local.common_tags
}

# aws_iam_role_policy
resource "aws_iam_role_policy" "allow_s3_all" {
  name = "allow_s3_all-${local.naming_prefix}"
  role = aws_iam_role.allow_nginx_s3.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
                "arn:aws:s3:::${local.s3_bucket_name}",
                "arn:aws:s3:::${local.s3_bucket_name}/*"
            ]
    }
  ]
}
EOF

}