resource "aws_security_group" "sg-service-active-assessment" {
  name   = "service-active-assessment"
  vpc_id = "${aws_vpc.staging-hanica-new-vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-service-active-assessment"
  }

  description = "active-assessment Security Group"
}

resource "aws_security_group_rule" "sg-service-active-assessment-ssh-rule" {
  security_group_id = "${aws_security_group.sg-service-active-assessment.id}"
  type              = "ingress"
  from_port         = 0
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.office-ip}/32"]
}

resource "aws_security_group_rule" "sg-service-active-assessment-http-rule" {
  security_group_id = "${aws_security_group.sg-service-active-assessment.id}"
  type              = "ingress"
  from_port         = 0
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["${var.office-ip}/32"]
}

resource "aws_security_group_rule" "sg-service-active-assessment-https-rule" {
  security_group_id = "${aws_security_group.sg-service-active-assessment.id}"
  type              = "ingress"
  from_port         = 0
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["${var.office-ip}/32"]
}

# 秘密鍵とパスフレーズはwillnetさんに提供済み
# 秘密鍵とパスフレーズは下記を参照
# https://docs.google.com/spreadsheets/d/1GBRE5YapQWIEfQbcZS66yHEJsOaguxdKIZxe9X-6C48/edit#gid=0
resource "aws_key_pair" "service-active-assessment" {
  key_name   = "service-active-assessment-key"
  public_key = "${file("./files/ec2/active-assessment.pub")}"
}

resource "aws_instance" "service-active-assessment" {
  ami           = "${var.ubuntu-server-1804-ami-id}"
  availability_zone = "ap-northeast-1c"
  instance_type = "t2.large"
  key_name = "${aws_key_pair.service-active-assessment.key_name}"

  monitoring           = true
  subnet_id = "${aws_subnet.staging-hanica-external-1c.id}"
  vpc_security_group_ids  = [
    "${aws_security_group.sg-service-active-assessment.id}",
  ]
  associate_public_ip_address = true

  # AWSのサービスを活用する際に設定する
  # iam_instance_profile = "${aws_iam_instance_profile.service-active-assessment-role.name}"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "100"
    delete_on_termination = true
  }

  tags = {
    Name = "service-active-assessment"
  }
}
