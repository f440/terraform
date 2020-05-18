resource "aws_security_group" "sg-kiban-service-fivetran" {
  name   = "service-fivetran"
  vpc_id = var.vpc-hanica-new-vpc

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kiban-service-fivetran"
  }

  description = "fivetran Security Group"
}

resource "aws_security_group_rule" "sg-kiban-service-fivetran-ssh-rule" {
  security_group_id = aws_security_group.sg-kiban-service-fivetran.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = [
    "${var.office-ip}/32",
    "35.227.135.0/29",
    "35.234.176.144/29",
    "52.0.2.4/32",
  ]
}

# 秘密鍵とパスフレーズは下記を参照
# https://docs.google.com/spreadsheets/d/1GBRE5YapQWIEfQbcZS66yHEJsOaguxdKIZxe9X-6C48/edit#gid=0
resource "aws_key_pair" "kiban-service-fivetran" {
  key_name   = "kiban-service-fivetran"
  public_key = file("./files/ec2/keys/kiban-service-fivetran.pub")
}

# fivetranからのssh許可用に設定する
resource "aws_eip" "kiban-service-fivetran-koban" {
  vpc      = true
  instance = aws_instance.kiban-service-fivetran-koban.id

  tags = {
    Name = "kiban-service-fivetran-koban"
  }
}

resource "aws_instance" "kiban-service-fivetran-koban" {
  ami                     = var.kiban-service-fivetran-latest-ami-id
  availability_zone       = "ap-northeast-1c"
  instance_type           = "t3.large"
  key_name                = aws_key_pair.kiban-service-fivetran.key_name
  disable_api_termination = true
  monitoring              = true

  subnet_id = var.vpc_subnet_hanica_external_1c_id
  vpc_security_group_ids = [
    aws_security_group.sg-kiban-service-fivetran.id,
  ]
  associate_public_ip_address = true

  user_data = data.template_cloudinit_config.kiban-service-fivetran-koban.rendered

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "100"
    delete_on_termination = true
  }

  tags = {
    Name = "kiban-service-fivetran-koban"
  }
}

resource "aws_eip" "kiban-service-fivetran-omen" {
  vpc      = true
  instance = aws_instance.kiban-service-fivetran-omen.id

  tags = {
    Name = "kiban-service-fivetran-omen"
  }
}

resource "aws_instance" "kiban-service-fivetran-omen" {
  ami                     = var.kiban-service-fivetran-latest-ami-id
  availability_zone       = "ap-northeast-1c"
  instance_type           = "t2.large"
  key_name                = aws_key_pair.kiban-service-fivetran.key_name
  disable_api_termination = true
  monitoring              = true

  subnet_id = var.vpc_subnet_hanica_external_1c_id
  vpc_security_group_ids = [
    aws_security_group.sg-kiban-service-fivetran.id,
  ]
  associate_public_ip_address = true

  user_data = data.template_cloudinit_config.kiban-service-fivetran-omen.rendered

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "100"
    delete_on_termination = true
  }

  tags = {
    Name = "kiban-service-fivetran-omen"
  }
}

resource "aws_eip" "kiban-service-fivetran-oke" {
  vpc      = true
  instance = aws_instance.kiban-service-fivetran-oke.id

  tags = {
    Name = "kiban-service-fivetran-oke"
  }
}

resource "aws_instance" "kiban-service-fivetran-oke" {
  ami                     = var.kiban-service-fivetran-latest-ami-id
  availability_zone       = "ap-northeast-1c"
  instance_type           = "t2.large"
  key_name                = aws_key_pair.kiban-service-fivetran.key_name
  disable_api_termination = true
  monitoring              = true

  subnet_id = var.vpc_subnet_hanica_external_1c_id
  vpc_security_group_ids = [
    aws_security_group.sg-kiban-service-fivetran.id,
  ]
  associate_public_ip_address = true

  user_data = data.template_cloudinit_config.kiban-service-fivetran-oke.rendered

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "100"
    delete_on_termination = true
  }

  tags = {
    Name = "kiban-service-fivetran-oke"
  }
}