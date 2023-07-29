# aws ami data
data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["3735637829"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}
# local azs
locals {
  azs = data.aws_availability_zone.available.names
}
data "aws_availability_zone" "available" {}

# Find the account ID
data "aws_caller_identity" "current" {}

# Find the region
data "aws_region" "current" {}

# Find all available zones within the region
data "aws_availability_zones" "available" {
  state = "available"
}
