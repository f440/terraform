##################################################
#
# rundeck
#
##################################################

# NOTE: terraformer import aws --resources=ec2_instance --regions=ap-northeast-1 --filter=aws_instance=i-08b6add321aae8e6a
#       でインポートしたものをベース
resource "aws_instance" "rundeck" {
  ami                         = var.rundeck-ami-id
  associate_public_ip_address = "false"
  cpu_core_count              = "1"
  cpu_threads_per_core        = "2"
  disable_api_termination     = "true"
  ebs_optimized               = "true"
  get_password_data           = "false"
  iam_instance_profile        = aws_iam_instance_profile.rundeck-instance-profile.name
  instance_type               = "m5.large"
  ipv6_address_count          = "0"
  key_name                    = "Hanica"
  monitoring                  = "true"

  root_block_device {
    delete_on_termination = "true"
    iops                  = "180"
    volume_size           = "60"
    volume_type           = "gp2"
  }

  source_dest_check = "true"
  subnet_id         = var.vpc_subnet_hanica_internal_1a_id

  tags = {
    Name                   = "rundeck"
    AmazonInspectorProfile = "base+network_inspector_group"
  }

  tenancy = "default"

  volume_tags = {
    Name = "rundeck"
  }

  vpc_security_group_ids = [
    aws_security_group.hanica-rundeck-sg.id
  ]
}

##################################################
#
# IAMロール RundeckRole
#
##################################################
resource "aws_iam_role" "rundeck-role" {
  name               = "RundeckRole"
  assume_role_policy = file("./files/iam/roles/ec2-assume.json")
}

resource "aws_iam_instance_profile" "rundeck-instance-profile" {
  name = aws_iam_role.rundeck-role.name
  role = aws_iam_role.rundeck-role.name
}

resource "aws_iam_role_policy_attachment" "rundeck-role-ssm-attachment" {
  role       = aws_iam_role.rundeck-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "rundeck-role-cloudwatch-attachment" {
  role       = aws_iam_role.rundeck-role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# アクセスアドバイザーとCloudTrailログから必要そうなポリシーを割り当て
resource "aws_iam_role_policy_attachment" "rundeck-role-cfn-attachment" {
  role       = aws_iam_role.rundeck-role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCloudFormationReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "rundeck-role-elb-attachment" {
  role       = aws_iam_role.rundeck-role.name
  policy_arn = "arn:aws:iam::aws:policy/ElasticLoadBalancingReadOnly"
}

resource "aws_iam_role_policy_attachment" "rundeck-role-ec2-attachment" {
  role       = aws_iam_role.rundeck-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "rundeck-role-autoscaling-attachment" {
  role       = aws_iam_role.rundeck-role.name
  policy_arn = "arn:aws:iam::aws:policy/AutoScalingReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "rundeck-role-eb-attachment" {
  role       = aws_iam_role.rundeck-role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkFullAccess"
}

resource "aws_iam_role_policy_attachment" "rundeck-role-ecr-attachment" {
  role       = aws_iam_role.rundeck-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "rundeck-role-route53-attachment" {
  role       = aws_iam_role.rundeck-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
}
