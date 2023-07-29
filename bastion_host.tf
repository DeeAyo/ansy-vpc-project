resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.ubuntu_newest.id
  instance_type          = var.bastion_instance_type
  subnet_id              = aws_subnet.public-subnet[count.index].id
  vpc_security_group_ids = [aws_security_group.default-main.id]
  key_name               = var.ssh_key_pairs[terraform.workspace]
  iam_instance_profile   = var.instance_profile
  count                  = 1

  #EBS root disk
  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = false
    encrypted             = true
  }

  user_data = <<EOF
		  #! /bin/bash
      sudo apt-get update
      sudo apt-get upgrade
	  EOF

  tags = merge(
    var.additional_tags,
    {
      Name        = "${terraform.workspace}-bastion"
      service     = "bastion server"
      environment = var.environment
      account_id  = local.account_id
      workspace   = terraform.workspace
    }
  )
}

/*
# Create Elastic IP for bastion Server
resource "aws_eip" "bastion_eip" {
  vpc      = true
  count    = 1 
  instance = aws_instance.bastion[count.index].id

  tags = merge(
    var.additional_tags,
    {
      Name        = "${terraform.workspace}-bastion-eip"
      service     = "elastic ip for the bastion server"
      environment = var.environment
      account_id  = local.account_id
      workspace   = terraform.workspace
    }
  )
}
*/