resource "aws_route53_zone" "kokeshi-local-private" {
    name       = "kokeshi.local"
    comment    = ""
    vpc_id     = "vpc-813df2e4"
    vpc_region = "ap-northeast-1"

    tags {
    }
}
