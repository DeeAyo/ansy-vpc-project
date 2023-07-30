
resource "aws_key_pair" "ansy_auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "random_id" "random" {
  byte_length = 2
  count       = var.main_instance_count

}


# Create ec2 Server 1
resource "aws_instance" "ansy_instance1" {
  ami                    = data.aws_ami.server_ami.id
  instance_type          = var.main_instance_type
  subnet_id              = aws_subnet.ansy-private-subnet[count.index].id
  vpc_security_group_ids = [aws_security_group.default-main.id]
  key_name               = var.ssh_key_pairs[terraform.workspace]
  count                  = 1
  iam_instance_profile   = var.instance_profile

  #EBS root disk
  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = true
    encrypted             = true
  }

  tags = merge(
    var.additional_tags,
    {
      Name        = "${terraform.workspace}-ansy_instance"
      service     = "ansy_
      environment = var.environment
      account_id  = local.account_id
      workspace   = terraform.workspace
    }
  )
}

# Create Elastic IP for ansy_instance
resource "aws_eip" "ansy_instance-eip" {
  instance = aws_instance.ansy_instance[count.index].id
  vpc      = true
  count    = 1

  tags = merge(
    var.additional_tags,
    {
      Name        = "${terraform.workspace}-boss-eip"
      service     = "elastic ip for ansy_instance"
      environment = var.environment
      account_id  = local.account_id
      workspace   = terraform.workspace
    }
  )
}