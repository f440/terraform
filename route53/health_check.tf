resource "aws_route53_health_check" "asterisk_hanica_me_health_check" {
  type                            = "HTTPS"
  fqdn                            = "app.hanica.me"
  port                            = "443"
  resource_path                   = "/health_check?from=r53_health_check"
  request_interval                = "30"
  failure_threshold               = "3"
  insufficient_data_health_status = ""

  tags {
    Name = "asterisk_hanica_me_health_check"
  }
}
