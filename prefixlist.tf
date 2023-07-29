#resource "aws_prefix_list" "home-network-pl" {
resource "aws_ec2_managed_prefix_list" "home-network" {
  name           = "Temporary-Home-office-Networks"
  address_family = "IPv4"
  max_entries    = 6




  entry {
    cidr        = "0.0.0.1/32"
    description = "temp: ayo home"
  }


  entry {
    cidr        = "0.0.0.5/32"
    description = "temp: ayo's office"
  }

  tags = merge(
    var.additional_tags, {

      service     = "temporary-prefix list"
      environment = var.environment
      account_id  = local.account_id
      workspace   = terraform.workspace
    }
  )
}
