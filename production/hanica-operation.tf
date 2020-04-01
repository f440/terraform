##################################################
#
# hanica-operation
#
##################################################

# NOTE: terraformer import aws --resources=ec2_instance --regions=ap-northeast-1 --filter=aws_instance=i-0a764d873409bb1b6
#       でインポートしたものをベース
resource "aws_instance" "hanica-operation" {
  ami                         = var.hanica-operation-ami-id
  associate_public_ip_address = "false"
  cpu_core_count              = "1"
  cpu_threads_per_core        = "1"

  credit_specification {
    cpu_credits = "standard"
  }

  disable_api_termination = "true"
  ebs_optimized           = "false"
  get_password_data       = "false"
  iam_instance_profile    = aws_iam_instance_profile.hanica-basic-instance-profile.name
  instance_type           = "t2.nano"
  ipv6_address_count      = "0"
  key_name                = "Hanica"
  monitoring              = "true"

  root_block_device {
    delete_on_termination = "true"
    iops                  = "100"
    volume_size           = "20"
    volume_type           = "gp2"
  }

  source_dest_check = "true"
  subnet_id         = var.vpc_subnet_hanica_internal_1a_id

  tags = {
    Name                   = "hanica-operaiton"
    AmazonInspectorProfile = "base+network_inspector_group"
  }

  tenancy = "default"

  volume_tags = {
    Name = "hanica-operaiton"
  }

  vpc_security_group_ids = [
    aws_security_group.hanica-rundeck-sg.id,
    var.sg-default
  ]
}

##################################################
#
# セキュリティグループ hanica-rundeck-sg
#
##################################################
resource "aws_security_group" "hanica-rundeck-sg" {
  name        = "hanica-rundeck-sg"
  description = "hanica-rundeck-sg"

  tags = {
    Name = "hanica-rundeck-sg"
  }

  vpc_id = var.vpc-hanica-new-vpc
}

resource "aws_security_group_rule" "hanica-rundeck-sg" {
  security_group_id = aws_security_group.hanica-rundeck-sg.id
  type              = "ingress"

  from_port                = "80"
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.new-alb-sg.id
  to_port                  = "80"
}

resource "aws_security_group_rule" "hanica-rundeck-sg-1" {
  security_group_id = aws_security_group.hanica-rundeck-sg.id
  type              = "ingress"

  cidr_blocks = ["10.0.0.0/16"]
  from_port   = "0"
  protocol    = "tcp"
  self        = "false"
  to_port     = "65535"
}

resource "aws_security_group_rule" "hanica-rundeck-sg-2" {
  security_group_id = aws_security_group.hanica-rundeck-sg.id
  type              = "ingress"

  from_port                = "8080"
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.new-alb-sg.id
  to_port                  = "8080"
}

resource "aws_security_group_rule" "hanica-rundeck-sg-3" {
  security_group_id = aws_security_group.hanica-rundeck-sg.id
  type              = "ingress"

  from_port                = "22"
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.hanica-bastion-sg.id
  to_port                  = "22"
}

resource "aws_security_group_rule" "hanica-rundeck-sg-4" {
  security_group_id = aws_security_group.hanica-rundeck-sg.id
  type              = "ingress"

  from_port                = "9090"
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.new-alb-sg.id
  to_port                  = "9090"
}

resource "aws_security_group_rule" "hanica-rundeck-sg-5" {
  security_group_id = aws_security_group.hanica-rundeck-sg.id
  type              = "ingress"

  from_port                = "4440"
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.new-alb-sg.id
  to_port                  = "4440"
}

resource "aws_security_group_rule" "hanica-rundeck-sg-6" {
  security_group_id = aws_security_group.hanica-rundeck-sg.id
  type              = "ingress"

  from_port                = "3000"
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.new-alb-sg.id
  to_port                  = "3000"
}

resource "aws_security_group_rule" "hanica-rundeck-sg-7" {
  security_group_id = aws_security_group.hanica-rundeck-sg.id
  type              = "ingress"

  from_port                = "8088"
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.new-alb-sg.id
  to_port                  = "8088"
}

resource "aws_security_group_rule" "hanica-rundeck-sg-8" {
  security_group_id = aws_security_group.hanica-rundeck-sg.id
  type              = "ingress"

  from_port                = "4443"
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.new-alb-sg.id
  to_port                  = "4443"
}

resource "aws_security_group_rule" "hanica-rundeck-sg-9" {
  security_group_id = aws_security_group.hanica-rundeck-sg.id
  type              = "ingress"

  from_port                = "443"
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.new-alb-sg.id
  to_port                  = "443"
}

resource "aws_security_group_rule" "hanica-rundeck-sg-10" {
  security_group_id = aws_security_group.hanica-rundeck-sg.id
  type              = "egress"

  cidr_blocks = ["0.0.0.0/0"]
  from_port   = "0"
  protocol    = "-1"
  self        = "false"
  to_port     = "0"
}

##################################################
#
# セキュリティグループ new-alb-sg
#
##################################################
resource "aws_security_group" "new-alb-sg" {
  name        = "new-alb-sg"
  description = "new-alb-sg"

  tags = {
    Name = "new-alb-sg"
  }

  vpc_id = var.vpc-hanica-new-vpc
}

resource "aws_security_group_rule" "new-alb-sg-egress" {
  security_group_id = aws_security_group.new-alb-sg.id
  type              = "egress"

  cidr_blocks = ["0.0.0.0/0"]
  from_port   = "0"
  protocol    = "-1"
  self        = "false"
  to_port     = "0"
}
