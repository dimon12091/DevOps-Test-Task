locals {
  # Automatically load region-level variables
  aws_region = "eu-west-2"
  project    = "geniusee-devops-task"
}

# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"
}
EOF
}

# Generate terraform.tfvars
generate "terraform.tfvars" {
  path      = "terraform.tfvars"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
region   = "${local.aws_region}"
project  = "${local.project}"
EOF
}

remote_state {
  backend  = "s3"
  generate = {
    path      = "config.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "terraform-state-${local.project}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "${local.aws_region}"
    encrypt        = true
    dynamodb_table = "terraform-up-and-running-locks"
  }
}

