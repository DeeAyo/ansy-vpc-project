resource "aws_subnet" "ansy-public-subnet" {
  count                   = length(local.azs)
  vpc_id                  = aws_vpc.ansy_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 2, count.index)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    var.additional_tags,
    {
      Name        = "${terraform.workspace}-subnet-public_${count.index + 1}${lower(substr(data.aws_availability_zones.available.names[count.index], -1, 1))}"
      service     = "public subnet"
      environment = var.environment
      account_id  = local.account_id
      workspace   = terraform.workspace
    }
  )
}



resource "aws_subnet" "ansy-private-subnet" {
  count                   = length(local.azs)
  vpc_id                  = aws_vpc.ansy_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 1, length(local.azs) + count.index)
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zone.available.names[count.index]

  tags = merge(
    var.additional_tags,
    {
      Name        = "${terraform.workspace}-subnet-public_${count.index + 1}${lower(substr(data.aws_availability_zones.available.names[count.index], -1, 1))}"
      service     = "private subnet"
      environment = var.environment
      account_id  = local.account_id
      workspace   = terraform.workspace
    }
  )
}