resource "aws_route53_record" "aoyagi-farm-NS" {
  zone_id = var.aoyagi_farm_zone_id
  name    = "aoyagi.farm"
  type    = "NS"
  records = ["ns-1203.awsdns-22.org.", "ns-672.awsdns-20.net.", "ns-110.awsdns-13.com.", "ns-1908.awsdns-46.co.uk."]
  ttl     = "172800"
}

resource "aws_route53_record" "aoyagi-farm-SOA" {
  zone_id = var.aoyagi_farm_zone_id
  name    = "aoyagi.farm"
  type    = "SOA"
  records = ["ns-1203.awsdns-22.org. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
  ttl     = "900"
}

resource "aws_route53_record" "koban-staging-aoyagi-farm-CNAME" {
  zone_id = var.aoyagi_farm_zone_id
  name    = "koban-staging.aoyagi.farm"
  type    = "CNAME"
  records = ["koban-staging.aoyagi.farm.herokudns.com"]
  ttl     = "300"
}

// Memo: 他とドメインの付け方が異なるので削除する
resource "aws_route53_record" "oke-aoyagi-farm-CNAME" {
  zone_id = var.aoyagi_farm_zone_id
  name    = "oke.aoyagi.farm"
  type    = "CNAME"
  records = ["tranquil-olive-zojtnz92vfayroeh7i6b2kau.herokudns.com"]
  ttl     = "60"
}

resource "aws_route53_record" "oke-staging-aoyagi-farm-A" {
  zone_id = var.aoyagi_farm_zone_id
  name    = "oke-staging.aoyagi.farm"
  type    = "A"

  alias {
    name                   = "dualstack.oke-staging-alb-1511983151.ap-northeast-1.elb.amazonaws.com"
    zone_id                = "Z14GRHDCWA56QT"
    evaluate_target_health = false
  }
}

// Memo: 他とドメインの付け方が異なるので削除する
resource "aws_route53_record" "ayatori-aoyagi-farm-CNAME" {
  zone_id         = var.aoyagi_farm_zone_id
  name            = "ayatori.aoyagi.farm"
  type            = "CNAME"
  records         = ["octagonal-dromiceiomimus-qtwabk05kjnpttmgehd2cjt5.herokudns.com"]
  ttl             = "300"
  allow_overwrite = "true"
}

resource "aws_route53_record" "ayatori-staging-aoyagi-farm-CNAME" {
  zone_id = var.aoyagi_farm_zone_id
  name    = "ayatori-staging.aoyagi.farm"
  type    = "CNAME"
  records = ["floral-corythosaurus-y789hlhpnjtw52uq55wf7bpz.herokudns.com"]
  ttl     = "60"
}

resource "aws_route53_record" "kotori-staging-aoyagi-farm-CNAME" {
  zone_id = var.aoyagi_farm_zone_id
  name    = "kotori-staging.aoyagi.farm"
  type    = "CNAME"
  records = ["gentle-swan-a8wtloiepn1bh3jfvpzt8383.herokudns.com"]
  ttl     = "60"
}

resource "aws_route53_record" "omen-staging-aoyagi-farm-CNAME" {
  zone_id = var.aoyagi_farm_zone_id
  name    = "omen-staging.aoyagi.farm"
  type    = "CNAME"
  records = ["mathematical-hamster-cn3g0qwhhfzwvjbir1r1ehjw.herokudns.com"]
  ttl     = "60"
}

resource "aws_route53_record" "omen-api-staging-aoyagi-farm-CNAME" {
  zone_id = var.aoyagi_farm_zone_id
  name    = "omen-api-staging.aoyagi.farm"
  type    = "CNAME"
  records = ["polar-bastion-0fb9poudvfaayct798fqvd9m.herokudns.com"]
  ttl     = "60"
}

resource "aws_route53_record" "maizo-staging-aoyagi-farm-CNAME" {
  zone_id = var.aoyagi_farm_zone_id
  name    = "maizo-staging.aoyagi.farm"
  type    = "CNAME"
  records = ["pure-hare-sml1yd2g5tirti7zqg6xsz1r.herokudns.com"]
  ttl     = "60"
}

resource "aws_route53_record" "shiritori-staging-aoyagi-farm-CNAME" {
  zone_id = var.aoyagi_farm_zone_id
  name    = "shiritori-staging.aoyagi.farm"
  type    = "CNAME"
  records = ["stormy-pinchusion-24o4ky5j933w976ph3pvcode.herokudns.com"]
  ttl     = "60"
}

resource "aws_route53_record" "sekitori-staging-aoyagi-farm-CNAME" {
  zone_id = var.aoyagi_farm_zone_id
  name    = "sekitori-staging.aoyagi.farm"
  type    = "CNAME"
  records = ["dimensional-yucca-wzzpto8omn61zzl1ow41dn98.herokudns.com"]
  ttl     = "60"
}

# Memo: 後々、削除ように対応する
resource "aws_route53_record" "shiritori-aoyagi-farm-CNAME" {
  zone_id = var.aoyagi_farm_zone_id
  name    = "shiritori.aoyagi.farm"
  type    = "CNAME"
  records = ["sleepy-hoverfly-xvsc3q5dwxhld20kcjzskzcg.herokudns.com"]
  ttl     = "60"
}

# Memo: 後々、削除するように対応する
resource "aws_route53_record" "sekitori-aoyagi-farm-CNAME" {
  zone_id = var.aoyagi_farm_zone_id
  name    = "sekitori.aoyagi.farm"
  type    = "CNAME"
  records = ["opaque-lemon-98n9ys665q5pta9cvdd3q5oj.herokudns.com"]
  ttl     = "60"
}

resource "aws_route53_record" "shittori-staging-aoyagi-farm-CNAME" {
  zone_id = var.aoyagi_farm_zone_id
  name    = "shittori-staging.aoyagi.farm"
  type    = "CNAME"
  records = ["tropical-puffin-eputd3gsy6wbcbjkcx60zn7n.herokudns.com"]
  ttl     = "60"
}

resource "aws_route53_record" "tatami-staging-aoyagi-farm-CNAME" {
  zone_id = var.aoyagi_farm_zone_id
  name    = "tatami-staging.aoyagi.farm"
  type    = "CNAME"
  records = ["pacific-rose-5ztud21qobl3ufuwwprd97dr.herokudns.com"]
  ttl     = "60"
}

resource "aws_route53_record" "asterisk-tatami-staging-aoyagi-farm-CNAME" {
  zone_id = var.aoyagi_farm_zone_id
  name    = "*.tatami-staging.aoyagi.farm"
  type    = "CNAME"
  records = ["powerful-journey-4406.thawing-headland-5882.herokuspace.com"]
  ttl     = "60"
}

resource "aws_route53_record" "meyasu-staging-aoyagi-farm-CNAME" {
  zone_id = var.aoyagi_farm_zone_id
  name    = "meyasu-staging.aoyagi.farm"
  type    = "CNAME"
  records = ["arcane-reef-4627.thawing-headland-5882.herokuspace.com"]
  ttl     = "60"
}

resource "aws_route53_record" "asterisk-meyasu-staging-aoyagi-farm-CNAME" {
  zone_id = var.aoyagi_farm_zone_id
  name    = "*.meyasu-staging.aoyagi.farm"
  type    = "CNAME"
  records = ["protected-ravine-8610.thawing-headland-5882.herokuspace.com"]
  ttl     = "60"
}

resource "aws_route53_record" "meyasu-staging-TXT" {
  zone_id = var.aoyagi_farm_zone_id
  name    = "_acme-challenge.meyasu-staging.aoyagi.farm"
  type    = "TXT"
  records = ["CYlsvHL5-ILyrMMWd5GNVundjdyvw6wBdSUF99YKDWU"]
  ttl     = "60"
}

resource "aws_route53_record" "jougo-staging-aoyagi-farm-CNAME" {
  zone_id = var.aoyagi_farm_zone_id
  name    = "jougo-staging.aoyagi.farm"
  type    = "CNAME"
  records = ["concentric-gallimimus-damccwc80nxysaoybndxmydq.herokudns.com"]
  ttl     = "60"
}

resource "aws_route53_record" "sakidori-pca-dx-staging-aoyagi-farm-CNAME" {
  zone_id = var.aoyagi_farm_zone_id
  name    = "sakidori-pca-dx-staging.aoyagi.farm"
  type    = "CNAME"
  records = ["cardiovascular-partridge-uflb3y02izgy4ip22zgstdvu.herokudns.com"]
  ttl     = "60"
}

resource "aws_route53_record" "sakidori-pca-hyper-staging-aoyagi-farm-CNAME" {
  zone_id = var.aoyagi_farm_zone_id
  name    = "sakidori-pca-hyper-staging.aoyagi.farm"
  type    = "CNAME"
  records = ["animate-lobster-7fkyzr3hh5coe6rwj8ta6m0b.herokudns.com"]
  ttl     = "60"
}

