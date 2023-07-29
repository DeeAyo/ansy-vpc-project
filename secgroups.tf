# Define the security group for Rancher Cluster VMs

resource "aws_security_group" "ansy-sg" {
  name        = "public_sg"
  description = "security group for public instance"
  vpc_id      = aws_vpc.ansy_vpc.id
}

resource "aws_security_group_rule" "ingress_all" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = [var.access.ip]
  security_group_id = aws_security_group.ansy-sg.id

}

resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ansy-sg.id

}