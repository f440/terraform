resource "aws_cloudfront_distribution" "smarthr-api-lp" {

  origin {
    domain_name           = "smarthr-api-lp.s3.amazonaws.com"
    origin_id             = "S3-smarthr-api-lp"
    origin_path           = ""
  }

  enabled             = true
  is_ipv6_enabled     = false
  default_root_object = "index.html"
  http_version        = "http1.1"
  price_class         = "PriceClass_All"

  aliases = ["developer.smarthr.jp"]

  custom_error_response {
    error_caching_min_ttl = 1
    error_code = "403"
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-smarthr-api-lp"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 1
    default_ttl            = 1
    max_ttl                = 1
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn             = "arn:aws:acm:us-east-1:736134917012:certificate/d91a39a5-020d-4c45-a706-9485c80f7c9b"
    cloudfront_default_certificate  = false
    minimum_protocol_version        = "TLSv1"
    ssl_support_method              = "sni-only"
  }
}
