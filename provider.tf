#
# This file is purely to trigger the download of the provider
# when the Dockerfile build runs the terraform init
#
# https://registry.terraform.io/browse/providers
#

# https://registry.terraform.io/providers/hashicorp/aws/latest
provider "aws" {}

# https://registry.terraform.io/providers/hashicorp/archive/latest
provider "archive" {}
