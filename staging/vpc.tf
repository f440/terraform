resource "aws_vpc" "staging-hanica-new-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "staging-hanica-new-vpc"
  }
}

/* subnet */
resource "aws_subnet" "staging-hanica-external-1a" {
  vpc_id            = "${aws_vpc.staging-hanica-new-vpc.id}"
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "staging-hanica-external-1a"
  }
}

resource "aws_subnet" "staging-hanica-external-1c" {
  vpc_id            = "${aws_vpc.staging-hanica-new-vpc.id}"
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "staging-hanica-external-1c"
  }
}

resource "aws_subnet" "staging-hanica-internal-1a" {
  vpc_id            = "${aws_vpc.staging-hanica-new-vpc.id}"
  cidr_block        = "10.0.128.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "staging-hanica-internal-1a"
  }
}

resource "aws_subnet" "staging-hanica-internal-1c" {
  vpc_id            = "${aws_vpc.staging-hanica-new-vpc.id}"
  cidr_block        = "10.0.130.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "staging-hanica-internal-1c"
  }
}

/* RouteTable */
resource "aws_route_table" "staging-hanica-external-rt" {
  vpc_id         = "${aws_vpc.staging-hanica-new-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.staging-hanica-new-igw.id}"
  }

  tags = {
    Name = "staging-hanica-external-rt"
  }
}

resource "aws_main_route_table_association" "staging-hanica-external-rt" {
  vpc_id         = "${aws_vpc.staging-hanica-new-vpc.id}"
  route_table_id = "${aws_route_table.staging-hanica-external-rt.id}"
}

resource "aws_route_table_association" "staging-hanica-external-1a" {
  subnet_id      = "${aws_subnet.staging-hanica-external-1a.id}"
  route_table_id = "${aws_route_table.staging-hanica-external-rt.id}"
}

resource "aws_route_table_association" "staging-hanica-external-1c" {
  subnet_id      = "${aws_subnet.staging-hanica-external-1c.id}"
  route_table_id = "${aws_route_table.staging-hanica-external-rt.id}"
}

resource "aws_route_table" "staging-hanica-internal-rt-1a" {
  vpc_id            = "${aws_vpc.staging-hanica-new-vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.staging-hanica-new-vpc-1a-ngw.id}"
  }

  tags = {
    Name = "staging-hanica-internal-rt-1a"
  }
}

resource "aws_route_table_association" "staging-hanica-internal-1a" {
  subnet_id      = "${aws_subnet.staging-hanica-internal-1a.id}"
  route_table_id = "${aws_route_table.staging-hanica-internal-rt-1a.id}"
}

resource "aws_route_table" "staging-hanica-internal-rt-1c" {
  vpc_id            = "${aws_vpc.staging-hanica-new-vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.staging-hanica-new-vpc-1c-ngw.id}"
  }

  tags = {
    Name = "staging-hanica-internal-rt-1c"
  }
}

resource "aws_route_table_association" "staging-hanica-internal-1c" {
  subnet_id      = "${aws_subnet.staging-hanica-internal-1c.id}"
  route_table_id = "${aws_route_table.staging-hanica-internal-rt-1c.id}"
}

/* internet gateway */
resource "aws_internet_gateway" "staging-hanica-new-igw" {
  vpc_id = "${aws_vpc.staging-hanica-new-vpc.id}"

  tags = {
    Name = "staging-hanica-new-igw"
  }
}

/* dhcp option set */
resource "aws_vpc_dhcp_options" "staging-hanica-new-vpc" {
  domain_name         = "ap-northeast-1.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    Name = "staging-hanica-new-vpc"
  }
}

resource "aws_vpc_dhcp_options_association" "staging-hanica-new-vpc" {
  vpc_id          = "${aws_vpc.staging-hanica-new-vpc.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.staging-hanica-new-vpc.id}"
}

/* Elastic IP */
resource "aws_eip" "staging-nat-1a" {
  vpc = true

  tags = {
    Name = "staging-nat-1a"
  }
}

resource "aws_eip" "staging-nat-1c" {
  vpc = true

  tags = {
    Name = "staging-nat-1c"
  }
}

/* NAT Gateway */
resource "aws_nat_gateway" "staging-hanica-new-vpc-1a-ngw" {
  allocation_id = "${aws_eip.staging-nat-1a.id}"
  subnet_id     = "${aws_subnet.staging-hanica-external-1a.id}"

  tags = {
    Name = "staging-nat-1a"
  }
}

resource "aws_nat_gateway" "staging-hanica-new-vpc-1c-ngw" {
  allocation_id = "${aws_eip.staging-nat-1c.id}"
  subnet_id     = "${aws_subnet.staging-hanica-external-1c.id}"

  tags = {
    Name = "staging-nat-1c"
  }
}

