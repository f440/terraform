##################################################
#
# hanica-bastion
#
##################################################
resource "aws_iam_role" "bastion-role" {
  name               = "HanicaBastionRole"
  assume_role_policy = file("./files/iam/roles/ec2-assume.json")
}

resource "aws_iam_role_policy_attachment" "bastion-role-ssm-attachment" {
  role       = aws_iam_role.bastion-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "bastion-instance-profile" {
  name = aws_iam_role.bastion-role.name
  role = aws_iam_role.bastion-role.name
}


# NOTE: terraformer import aws --resources=ec2_instance --regions=ap-northeast-1 --filter=aws_instance=i-09a4cf5604a088fba
#       でインポートしたものをベース
resource "aws_instance" "hanica-bastion" {
  ami                         = var.hanica-bastion-ami-id
  associate_public_ip_address = "true"
  cpu_core_count              = "1"
  cpu_threads_per_core        = "1"

  credit_specification {
    cpu_credits = "standard"
  }

  disable_api_termination = "true"
  ebs_optimized           = "false"
  get_password_data       = "false"
  iam_instance_profile    = aws_iam_instance_profile.bastion-instance-profile.name
  instance_type           = "t2.nano"
  ipv6_address_count      = "0"
  key_name                = "Hanica"
  monitoring              = "true"
  private_ip              = "10.0.1.18"

  root_block_device {
    delete_on_termination = "true"
    iops                  = "100"
    volume_size           = "8"
    volume_type           = "gp2"
  }

  source_dest_check = "true"
  subnet_id         = var.vpc_subnet_hanica_external_1a_id

  tags = {
    Name                   = "hanica-bastion"
    AmazonInspectorProfile = "inspector_base_group"
  }

  tenancy = "default"
  vpc_security_group_ids = [
    aws_security_group.hanica-bastion-sg.id
  ]
}

resource "aws_security_group" "hanica-bastion-sg" {
  # NOTE: descriptionやnameを適切に変更したいものの、既存のグループが他のセキュリティグループから
  #       参照されているため、オリジナルのままで保持
  description = "launch-wizard-2 created 2017-09-21T17:50:56.604+09:00"
  name        = "hanica-docker-bastion-sg"

  # NOTE: 代わりにタグを適切に付けておく
  tags = {
    Name        = "hanica-bastion-sg"
    Description = "Security Group for hancia-bastion instance"
  }
  vpc_id = var.vpc-hanica-new-vpc
}

resource "aws_security_group_rule" "hanica-bastion-sg" {
  security_group_id = aws_security_group.hanica-bastion-sg.id

  type        = "ingress"
  cidr_blocks = ["150.249.198.101/32"]
  description = "RoppongiGrandTower dev_ops"
  from_port   = "22"
  protocol    = "tcp"
  self        = "false"
  to_port     = "22"
}

resource "aws_security_group_rule" "hanica-bastion-sg-1" {
  security_group_id = aws_security_group.hanica-bastion-sg.id

  type        = "egress"
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = "0"
  protocol    = "-1"
  self        = "false"
  to_port     = "0"
}

# NOTE: internal-sgからマージしたルール
resource "aws_security_group_rule" "hanica-bastion-sg-2" {
  security_group_id = aws_security_group.hanica-bastion-sg.id

  type        = "ingress"
  cidr_blocks = ["54.65.102.6/32"]
  description = "vpn"
  from_port   = "22"
  protocol    = "tcp"
  self        = "false"
  to_port     = "22"
}
