

resource "aws_vpc" "ansy_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true


  tags = merge(
    var.additional_tags,
    {
      Name        = "${terraform.workspace}-vpc"
      service     = "vpc"
      environment = var.environment
      account_id  = local.account_id
      workspace   = terraform.workspace
    }
  )
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_internet_gateway" "ansy_internet_gtw" {
  vpc_id = aws_vpc.ansy_vpc.id


  tags = merge(
    var.additional_tags,
    {
      Name        = "${terraform.workspace}-vpc"
      service     = "vpc"
      environment = var.environment
      account_id  = local.account_id
      workspace   = terraform.workspace
    }
  )

}

resource "aws_route_table" "ansy-public-rt" {
  vpc_id = aws_vpc.ansy_vpc.id

  tags = merge(
    var.additional_tags,
    {
      Name        = "${terraform.workspace}-rtb-public"
      service     = "route table"
      environment = var.environment
      account_id  = local.account_id
      workspace   = terraform.workspace
    }
  )
}

resource "aws_route" "default_route" {
  route_table_id = aws_route_table.ansy-public-rt.id
  cidr_block     = "0.0.0.0/0"
  gateway_id     = aws_internet_gateway.ansy_internet_gtw.id
}

resource "aws_default_route_table" "ansy_private_rt" {
  default_route_table_id = aws_vpc.ansy_vpc.default_route_table_id


  tags = merge(
    var.additional_tags,
    {
      Name        = "${terraform.workspace}-rtb-public"
      service     = "route table"
      environment = var.environment
      account_id  = local.account_id
      workspace   = terraform.workspace
    }
  )
}
resource "" "name" {
  
}


# Associate route table to subnets
resource "aws_route_table_association" "public-rt-association" {
  count          = length
  subnet_id      = aws_subnet.ansy-public-subnet[count.index].id
  route_table_id = aws_route_table.ansy-public-rt.id

  tags = merge(
    var.additional_tags,
    {
      Name        = "${terraform.workspace}-rtb-public"
      service     = "route table"
      environment = var.environment
      account_id  = local.account_id
      workspace   = terraform.workspace
    }
  )
}

