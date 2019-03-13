resource "aws_route53_record" "smarthr-plus-NS" {
  zone_id = "${var.smarthr_plus_zone_id}"
  name    = "smarthr.plus"
  type    = "NS"
  records = ["ns-158.awsdns-19.com.", "ns-1374.awsdns-43.org.", "ns-808.awsdns-37.net.", "ns-1753.awsdns-27.co.uk."]
  ttl     = "172800"
}

resource "aws_route53_record" "smarthr-plus-SOA" {
  zone_id = "${var.smarthr_plus_zone_id}"
  name    = "smarthr.plus"
  type    = "SOA"
  records = ["ns-158.awsdns-19.com. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
  ttl     = "900"
}

resource "aws_route53_record" "nencho-smarthr-plus-CNAME" {
  zone_id = "${var.smarthr_plus_zone_id}"
  name    = "nencho.smarthr.plus"
  type    = "CNAME"
  records = ["secret-ridge-6744.thawing-headland-5882.herokuspace.com"]
  ttl     = "300"
}

resource "aws_route53_record" "keiyaku-smarthr-plus-CNAME" {
  zone_id = "${var.smarthr_plus_zone_id}"
  name    = "keiyaku.smarthr.plus"
  type    = "CNAME"
  records = ["guarded-harbor-4023.thawing-headland-5882.herokuspace.com"]
  ttl     = "600"
}

resource "aws_route53_record" "kingoftime-smarthr-plus-CNAME" {
  zone_id = "${var.smarthr_plus_zone_id}"
  name    = "kingoftime.smarthr.plus"
  type    = "CNAME"
  records = ["evening-sands-1274.thawing-headland-5882.herokuspace.com"]
  ttl     = "300"
}

resource "aws_route53_record" "freee-smarthr-plus-CNAME" {
  zone_id = "${var.smarthr_plus_zone_id}"
  name    = "freee.smarthr.plus"
  type    = "CNAME"
  records = ["pacific-savannah-1783.thawing-headland-5882.herokuspace.com"]
  ttl     = "300"
}

resource "aws_route53_record" "custom-meibo-api-smarthr-plus-CNAME" {
  zone_id = "${var.smarthr_plus_zone_id}"
  name    = "custom-meibo-api.smarthr.plus"
  type    = "CNAME"
  records = ["stark-journey-8805.thawing-headland-5882.herokuspace.com"]
  ttl     = "300"
}

resource "aws_route53_record" "custom-meibo-smarthr-plus-CNAME" {
  zone_id = "${var.smarthr_plus_zone_id}"
  name    = "custom-meibo.smarthr.plus"
  type    = "CNAME"
  records = ["ancient-escarpment-8056.thawing-headland-5882.herokuspace.com"]
  ttl     = "300"
}

resource "aws_route53_record" "report-smarthr-plus-CNAME" {
  zone_id = "${var.smarthr_plus_zone_id}"
  name    = "report.smarthr.plus"
  type    = "CNAME"
  records = ["aqueous-tundra-2163.thawing-headland-5882.herokuspace.com"]
  ttl     = "300"
}

resource "aws_route53_record" "touchontime-smarthr-plus-CNAME" {
  zone_id = "${var.smarthr_plus_zone_id}"
  name    = "touchontime.smarthr.plus"
  type    = "CNAME"
  records = ["tranquil-ravine-7091.thawing-headland-5882.herokuspace.com"]
  ttl     = "300"
}

resource "aws_route53_record" "kinkakuji-smarthr-plus-CNAME" {
  zone_id = "${var.smarthr_plus_zone_id}"
  name    = "kinkakuji.smarthr.plus"
  type    = "CNAME"
  records = ["guarded-everglades-9737.thawing-headland-5882.herokuspace.com"]
  ttl     = "300"
}
