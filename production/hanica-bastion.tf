##################################################
#
# hanica-bastion
#
##################################################
resource "aws_iam_role" "bastion-role" {
  # TODO: 名前を適切なものに変えたい
  name               = "aws-elasticbeanstalk-ec2-role"
  assume_role_policy = file("./files/iam/roles/ec2-assume.json")
}

resource "aws_iam_role_policy_attachment" "bastion-role-ssm-attachment" {
  role       = aws_iam_role.bastion-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
# TODO: アクセスアドバイザーの履歴を見ると、以下のポリシーは利用されてないかも 不要なら削除したい
resource "aws_iam_role_policy_attachment" "bastion-role-ebwebtier-attachment" {
  role       = aws_iam_role.bastion-role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}
resource "aws_iam_role_policy_attachment" "bastion-role-ebdocker-attachment" {
  role       = aws_iam_role.bastion-role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
}
resource "aws_iam_role_policy_attachment" "bastion-role-ebworker-attachment" {
  role       = aws_iam_role.bastion-role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
}
resource "aws_iam_role_policy" "bastion-role-cloudwatch-policy" {
  # NOTE: 現状のリソースのtypo
  name   = "custom-clowdwatch-metrics"
  role   = aws_iam_role.bastion-role.name
  policy = file("./files/iam/policies/custom-cloudwatch-metrics-policy.json")
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
    Name = "hanica-bastion"
    InspectorProfile = "base"
  }

  tenancy                = "default"
  vpc_security_group_ids = [
    aws_security_group.hanica-docker-bastion-sg.id,
    aws_security_group.internal-sg.id
  ]
}

resource "aws_security_group" "hanica-docker-bastion-sg" {
  description = "launch-wizard-2 created 2017-09-21T17:50:56.604+09:00"

  # NOTE: terraform importのバグor仕様で、inlineルールがあってもaws_security_group_ruleも作られる
  #       余計な変更をしないために、外出しのルールの方を有効にしておく
  #egress {
  #  cidr_blocks = ["0.0.0.0/0"]
  #  from_port   = "0"
  #  protocol    = "-1"
  #  self        = "false"
  #  to_port     = "0"
  #}

  #ingress {
  #  cidr_blocks = ["150.249.198.101/32"]
  #  description = "RoppongiGrandTower dev_ops"
  #  from_port   = "22"
  #  protocol    = "tcp"
  #  self        = "false"
  #  to_port     = "22"
  #}

  name   = "hanica-docker-bastion-sg"
  vpc_id = var.vpc-hanica-new-vpc
}
resource "aws_security_group_rule" "hanica-docker-bastion-sg" {
  security_group_id = aws_security_group.hanica-docker-bastion-sg.id
  type = "ingress"

  cidr_blocks = ["150.249.198.101/32"]
  description = "RoppongiGrandTower dev_ops"
  from_port   = "22"
  protocol    = "tcp"
  self        = "false"
  to_port     = "22"
}
resource "aws_security_group_rule" "hanica-docker-bastion-sg-1" {
  security_group_id = aws_security_group.hanica-docker-bastion-sg.id
  type = "egress"

  cidr_blocks = ["0.0.0.0/0"]
  from_port   = "0"
  protocol    = "-1"
  self        = "false"
  to_port     = "0"
}

resource "aws_security_group" "internal-sg" {
  description = "internal-sg"

  # NOTE: terraform importのバグor仕様で、inlineルールがあってもaws_security_group_ruleも作られる
  #       余計な変更をしないために、外出しのルールの方を有効にしておく
  #egress {
  #  cidr_blocks = ["0.0.0.0/0"]
  #  from_port   = "0"
  #  protocol    = "-1"
  #  self        = "false"
  #  to_port     = "0"
  #}

  #ingress {
  #  cidr_blocks = ["150.249.198.101/32"]
  #  description = "RoppongiGrandTower dev_ops"
  #  from_port   = "0"
  #  protocol    = "-1"
  #  self        = "false"
  #  to_port     = "0"
  #}

  #ingress {
  #  cidr_blocks = ["54.65.102.6/32"]
  #  description = "vpn"
  #  from_port   = "0"
  #  protocol    = "-1"
  #  self        = "false"
  #  to_port     = "0"
  #}

  name   = "internal-sg"
  vpc_id = var.vpc-hanica-new-vpc
}
# WARNING: terraform importのバグで、ルールが集約されてしまいdescriptionの情報が落ちている
#          上のinlineルールが正しいので、再構築する時はinlineルールを有効、外出しルールを無効にする
resource "aws_security_group_rule" "internal-sg" {
  security_group_id = aws_security_group.internal-sg.id
  type = "ingress"

  cidr_blocks = [
    "54.65.102.6/32",
    "150.249.198.101/32"
  ]
  description = "vpn"
  from_port   = "0"
  protocol    = "-1"
  self        = "false"
  to_port     = "0"
}
resource "aws_security_group_rule" "internal-sg-1" {
  security_group_id = aws_security_group.internal-sg.id
  type = "egress"

  cidr_blocks = ["0.0.0.0/0"]
  from_port   = "0"
  protocol    = "-1"
  self        = "false"
  to_port     = "0"
}
