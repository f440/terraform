resource "aws_route53_zone" "hanica-me-public" {
  name    = "hanica.me"
  comment = ""

  tags {}
}

resource "aws_route53_zone" "daruma-space-public" {
  name    = "daruma.space"
  comment = ""

  tags {}
}

resource "aws_route53_zone" "smarthr-jp-public" {
  name    = "smarthr.jp"
  comment = ""

  tags {}
}

resource "aws_route53_zone" "smarthr-co-jp-public" {
  name    = "smarthr.co.jp"
  comment = ""

  tags {}
}

resource "aws_route53_zone" "kufuinc-com-public" {
  name    = "kufuinc.com"
  comment = ""

  tags {}
}

resource "aws_route53_zone" "hanica-local-private" {
  name       = "hanica.local"
  comment    = ""
  vpc_id     = "vpc-813df2e4"
  vpc_region = "ap-northeast-1"

  tags {}
}

resource "aws_route53_zone" "daruma-local-private" {
  name       = "daruma.local"
  comment    = ""
  vpc_id     = "vpc-813df2e4"
  vpc_region = "ap-northeast-1"

  tags {}
}

resource "aws_route53_zone" "udemushi-com-public" {
  name    = "udemushi.com"
  comment = "HostedZone created by Route53 Registrar"

  tags {}
}

resource "aws_route53_zone" "smarthr-plus-public" {
  name    = "smarthr.plus"
  comment = "HostedZone created by Route53 Registrar"

  tags {}
}

resource "aws_route53_zone" "aoyagi-farm-public" {
  name    = "aoyagi.farm"
  comment = "HostedZone created by Route53 Registrar"

  tags {}
}

resource "aws_route53_zone" "staging-smarthr-lp-com-public" {
  name    = "staging-smarthr-lp.com"
  comment = "HostedZone created by Route53 Registrar"

  tags {}
}

resource "aws_route53_zone" "akeome-cc-public" {
  name    = "akeome.cc"
  comment = "HostedZone created by Route53 Registrar"

  tags {}
}

resource "aws_route53_zone" "arigata-me-public" {
  name    = "arigata.me"
  comment = "HostedZone created by Route53 Registrar"

  tags {}
}

resource "aws_route53_zone" "cs-smarthr-jp-public" {
  name    = "cs.smarthr.jp"
  comment = ""

  tags {}
}

resource "aws_route53_zone" "hanica-internal-private" {
  name       = "hanica.internal"
  comment    = ""
  vpc_id     = "vpc-77586713"
  vpc_region = "ap-northeast-1"

  tags {}
}
