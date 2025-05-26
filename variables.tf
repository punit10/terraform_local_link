variable "aws_access_key" {
  type        = string
  description = "AWS Access keys"
  sensitive   = true
}

variable "aws_secret_key" {
  type        = string
  description = "AWS Secret keys"
  sensitive   = true
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  type        = string
  description = "Cidr block of aws vpc"
  default     = "10.0.0.0/16"
}

variable "vpc_public_subnet_count" {
  type        = number
  description = "Number of Public subnet to create"
  default     = 2
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "IS dns hostname enable"
  default     = true
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Public IP mapping on launch"
  default     = true
}

variable "vpc_public_subnets_cidr_block" {
  type        = list(string)
  description = "Cidr block for Subnets of aws vpc"
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "aws_instance_size" {
  type        = map(string)
  description = "Size of AWS ec2 instance"
  default = {
    micro  = "t2.micro"
    small  = "t2.small"
    medium = "t2.medium"
  }
}

variable "ec2_instance_count" {
  type        = number
  description = "Number of ec2 instance to create"
  default     = 2
}

# for local tags
variable "company" {
  type        = string
  description = "Name of the company"
  default     = "LocalLink"
}

variable "project" {
  type        = string
  description = "Project of the team"
}

variable "billing_code" {
  type        = string
  description = "Billing code"
}

variable "naming_prefix" {
  type        = string
  description = "Naming prefix for company resources names"
  default     = "local-link-app"
}

variable "environment" {
  type        = string
  description = "environment for which this config is created"
  default     = "dev"
}