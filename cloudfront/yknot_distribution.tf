resource "aws_cloudfront_distribution" "yknot-production" {

  origin {
    domain_name           = "yknot-production.s3.amazonaws.com"
    origin_id             = "S3-yknot-production"
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
    target_origin_id        = "S3-yknot-production"
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

  logging_config {
    bucket = "yknot-production.s3.amazonaws.com"
    prefix = "cf-logs/"
  }
}

resource "aws_cloudfront_distribution" "yknot-staging" {

  origin {
    domain_name           = "yknot-staging.s3.amazonaws.com"
    origin_id             = "S3-yknot-staging"
    origin_path           = ""
  }

  enabled             = true
  is_ipv6_enabled     = false
  http_version        = "http1.1"
  price_class         = "PriceClass_All"

  default_cache_behavior {
    compress                = false
    default_ttl             = 86400
    max_ttl                 = 31536000
    min_ttl                 = 0
    target_origin_id        = "S3-yknot-staging"
    viewer_protocol_policy  = "allow-all"
    smooth_streaming        = false

    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]

    forwarded_values {
      query_string  = false
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

  logging_config {
    bucket = "yknot-staging.s3.amazonaws.com"
    prefix = "cf-logs/"
  }
}

resource "aws_cloudfront_distribution" "yknot-development" {

  origin {
    domain_name           = "yknot-development.s3.amazonaws.com"
    origin_id             = "S3-yknot-development"
    origin_path           = ""
  }

  enabled             = true
  is_ipv6_enabled     = false
  http_version        = "http1.1"
  price_class         = "PriceClass_All"

  default_cache_behavior {
    compress                = false
    default_ttl             = 86400
    max_ttl                 = 31536000
    min_ttl                 = 0
    target_origin_id        = "S3-yknot-development"
    viewer_protocol_policy  = "allow-all"
    smooth_streaming        = false

    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]

    forwarded_values {
      query_string  = false
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

  logging_config {
    bucket          = "yknot-development.s3.amazonaws.com"
    prefix          = "cf-logs/"
    include_cookies = true
  }
}
