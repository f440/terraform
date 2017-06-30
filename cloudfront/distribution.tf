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
    allowed_methods         = ["GET", "HEAD"]
    cached_methods          = ["GET", "HEAD"]
    target_origin_id        = "S3-smarthr-api-lp"
    viewer_protocol_policy  = "redirect-to-https"
    min_ttl                 = 1
    default_ttl             = 1
    max_ttl                 = 1

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

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

resource "aws_cloudfront_distribution" "smarthr-production" {

  origin {
    domain_name           = "smarthr-production.s3.amazonaws.com"
    origin_id             = "S3-smarthr-production"
    origin_path           = ""
  }

  enabled             = true
  is_ipv6_enabled     = false
  http_version        = "http1.1"
  price_class         = "PriceClass_All"

  default_cache_behavior {
    default_ttl             = 86400
    max_ttl                 = 31536000
    min_ttl                 = 0
    target_origin_id        = "S3-smarthr-production"
    viewer_protocol_policy  = "allow-all"

    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]

    forwarded_values {
      query_string  = true
      headers       = ["Origin"]
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate  = true
    minimum_protocol_version        = "SSLv3"
  }
}

resource "aws_cloudfront_distribution" "smarthr-sandbox" {

  origin {
    domain_name           = "smarthr-sandbox.s3.amazonaws.com"
    origin_id             = "S3-smarthr-sandbox"
    origin_path           = ""
  }

  enabled             = true
  is_ipv6_enabled     = false
  http_version        = "http1.1"
  price_class         = "PriceClass_All"

  default_cache_behavior {
    default_ttl             = 86400
    max_ttl                 = 31536000
    min_ttl                 = 0
    target_origin_id        = "S3-smarthr-sandbox"
    viewer_protocol_policy  = "allow-all"

    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]

    forwarded_values {
      query_string  = true
      headers       = ["Origin"]
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate  = true
    minimum_protocol_version        = "SSLv3"
  }
}

resource "aws_cloudfront_distribution" "smarthr-staging" {

  origin {
    domain_name           = "smarthr-staging.s3.amazonaws.com"
    origin_id             = "S3-smarthr-staging"
    origin_path           = ""
  }

  enabled             = true
  is_ipv6_enabled     = false
  http_version        = "http1.1"
  price_class         = "PriceClass_All"

  default_cache_behavior {
    default_ttl             = 86400
    max_ttl                 = 31536000
    min_ttl                 = 0
    target_origin_id        = "S3-smarthr-staging"
    viewer_protocol_policy  = "allow-all"

    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]

    forwarded_values {
      query_string  = true
      headers       = ["Origin"]
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate  = true
    minimum_protocol_version        = "SSLv3"
  }
}

resource "aws_cloudfront_distribution" "sorry-hanica-me" {

  origin {
    domain_name           = "sorry-hanica-me.s3.amazonaws.com"
    origin_id             = "S3-sorry-hanica-me"
    origin_path           = ""
  }

  enabled             = true
  is_ipv6_enabled     = true
  http_version        = "http2"
  price_class         = "PriceClass_All"

  aliases = ["sorry.hanica.me"]

  custom_error_response {
    error_caching_min_ttl = 300
    error_code            = "403"
    response_code         = "503"
    response_page_path    = "/sorry.html"
  }

  default_cache_behavior {
    allowed_methods         = ["GET", "HEAD"]
    cached_methods          = ["GET", "HEAD"]
    target_origin_id        = "S3-sorry-hanica-me"
    viewer_protocol_policy  = "allow-all"
    default_ttl             = 86400
    max_ttl                 = 31536000
    min_ttl                 = 0

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate  = true
    minimum_protocol_version        = "SSLv3"
  }
}

