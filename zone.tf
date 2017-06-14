resource "aws_route53_zone" "skillsand-me-public" {
    name       = "skillsand.me"
    comment    = ""

    tags {
    }
}

resource "aws_route53_zone" "y-knot-jp-public" {
    name       = "y-knot.jp"
    comment    = ""

    tags {
    }
}

resource "aws_route53_zone" "hanica-me-public" {
    name       = "hanica.me"
    comment    = ""

    tags {
    }
}

resource "aws_route53_zone" "daruma-space-public" {
    name       = "daruma.space"
    comment    = ""

    tags {
    }
}

resource "aws_route53_zone" "smarthr-jp-public" {
    name       = "smarthr.jp"
    comment    = ""

    tags {
    }
}

resource "aws_route53_zone" "kokeshi-space-public" {
    name       = "kokeshi.space"
    comment    = ""

    tags {
    }
}

resource "aws_route53_zone" "smarthr-co-jp-public" {
    name       = "smarthr.co.jp"
    comment    = ""

    tags {
    }
}

resource "aws_route53_zone" "kufuinc-com-public" {
    name       = "kufuinc.com"
    comment    = ""

    tags {
    }
}

resource "aws_route53_zone" "hanica-local-private" {
    name       = "hanica.local"
    comment    = ""
    vpc_id     = "vpc-813df2e4"
    vpc_region = "ap-northeast-1"

    tags {
    }
}

resource "aws_route53_zone" "daruma-local-private" {
    name       = "daruma.local"
    comment    = ""
    vpc_id     = "vpc-813df2e4"
    vpc_region = "ap-northeast-1"

    tags {
    }
}

resource "aws_route53_zone" "kokeshi-local-private" {
    name       = "kokeshi.local"
    comment    = ""
    vpc_id     = "vpc-813df2e4"
    vpc_region = "ap-northeast-1"

    tags {
    }
}

resource "aws_route53_zone" "rumpes-co-uk-public" {
    name       = "rumpes.co.uk"
    comment    = "HostedZone created by Route53 Registrar"

    tags {
    }
}

resource "aws_route53_zone" "udemushi-com-public" {
    name       = "udemushi.com"
    comment    = "HostedZone created by Route53 Registrar"

    tags {
    }
}

