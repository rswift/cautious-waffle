#
# This file extracts away some details to help keep things a little more organised
#
# https://www.terraform.io/docs/configuration/terraform.html
# https://www.terraform.io/docs/configuration/version-constraints.html
#
terraform {
  required_version = "~> 1.0"

  #
  # Use S3 for state as the goal here is to demonstrate the use of CodeBuild
  # so a durable store is required. The state file is JSON.
  #
  # https://www.terraform.io/docs/language/settings/backends/s3.html
  # https://www.terraform.io/docs/state/index.html
  #
  backend "s3" {
    region = "eu-west-2"
    bucket = "my state bucket"
    key    = "State/example.tfstate"
  }

  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs#example-usage
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

#
# https://www.terraform.io/docs/providers/aws/index.html
#
provider "aws" {
  profile = "default"
  region  = "eu-west-2"
}
