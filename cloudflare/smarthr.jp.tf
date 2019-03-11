resource "cloudflare_record" "A_mag_smarthr_jp_bb4266a07a5a823092870551b4778f35" {
  domain = "smarthr.jp"

  name    = "mag.smarthr.jp"
  type    = "A"
  ttl     = "1"
  proxied = "false"

  value = "150.95.225.254"
}

resource "cloudflare_record" "A_o1_sg_smarthr_jp_164811c40f68fd00753c989ffdaf83cb" {
  domain = "smarthr.jp"

  name    = "o1.sg.smarthr.jp"
  type    = "A"
  ttl     = "1"
  proxied = "false"

  value = "168.245.113.131"
}

resource "cloudflare_record" "A_smarthr_jp_097a211eeb4599d25479279919860758" {
  domain = "smarthr.jp"

  name    = "smarthr.jp"
  type    = "A"
  ttl     = "1"
  proxied = "true"

  value = "133.130.16.158"
}

resource "cloudflare_record" "CNAME_0e2ec3229d46ff2dbc9d2240f2cc8b44_smarthr_jp_f17de5fda6174aba44cf26f47b823149" {
  domain = "smarthr.jp"

  name    = "0e2ec3229d46ff2dbc9d2240f2cc8b44.smarthr.jp"
  type    = "CNAME"
  ttl     = "1"
  proxied = "false"

  value = "verify.bing.com"
}

resource "cloudflare_record" "CNAME__a8c84229433b1d58185af97e191be56d_smarthr_jp_7db62b2e56a4eef8cdcf89e2a9d15137" {
  domain = "smarthr.jp"

  name    = "_a8c84229433b1d58185af97e191be56d.smarthr.jp"
  type    = "CNAME"
  ttl     = "1"
  proxied = "false"

  value = "_71daf99dd13ab372ad5a353dc116cb9b.tljzshvwok.acm-validations.aws"
}

resource "cloudflare_record" "CNAME_developer_smarthr_jp_baae26d4042ee9919f39842901420732" {
  domain = "smarthr.jp"

  name    = "developer.smarthr.jp"
  type    = "CNAME"
  ttl     = "1"
  proxied = "false"

  value = "d1221gzek7j9eo.cloudfront.net"
}

resource "cloudflare_record" "CNAME_email_cs_smarthr_jp_8d202ec5ea7824b94f36f05bcf9c7852" {
  domain = "smarthr.jp"

  name    = "email.cs.smarthr.jp"
  type    = "CNAME"
  ttl     = "1"
  proxied = "false"

  value = "mailgun.org"
}

resource "cloudflare_record" "CNAME_em_smarthr_jp_6239df102dd813d6e0559230a0131596" {
  domain = "smarthr.jp"

  name    = "em.smarthr.jp"
  type    = "CNAME"
  ttl     = "1"
  proxied = "false"

  value = "u2787976.wl227.sendgrid.net"
}

resource "cloudflare_record" "CNAME_envy_smarthr_jp_bf701a628568701fb63e191562ee63dc" {
  domain = "smarthr.jp"

  name    = "envy.smarthr.jp"
  type    = "CNAME"
  ttl     = "1"
  proxied = "false"

  value = "envy.smarthr.jp.herokudns.com"
}

resource "cloudflare_record" "CNAME_asterisk_event_smarthr_jp_210be8818d4bc532094ebd7cc0944584" {
  domain = "smarthr.jp"

  name    = "*.event.smarthr.jp"
  type    = "CNAME"
  ttl     = "1"
  proxied = "false"

  value = "secure.pageserve.co"
}

resource "cloudflare_record" "CNAME_intercom__domainkey_smarthr_jp_991cfe25c084b9fec6737bed1a896a0d" {
  domain = "smarthr.jp"

  name    = "intercom._domainkey.smarthr.jp"
  type    = "CNAME"
  ttl     = "1"
  proxied = "false"

  value = "a997f72a-4d4a-4fde-bef1-95bbd6b6c643.dkim.intercom.io"
}

resource "cloudflare_record" "CNAME_k1__domainkey_smarthr_jp_6586c07213dbec09293164378478cad9" {
  domain = "smarthr.jp"

  name    = "k1._domainkey.smarthr.jp"
  type    = "CNAME"
  ttl     = "1"
  proxied = "false"

  value = "dkim.mcsv.net"
}

resource "cloudflare_record" "CNAME_payment_smarthr_jp_eb2b9261004df07657b65a6db31be399" {
  domain = "smarthr.jp"

  name    = "payment.smarthr.jp"
  type    = "CNAME"
  ttl     = "1"
  proxied = "false"

  value = "payment.smarthr.jp.herokudns.com"
}

resource "cloudflare_record" "CNAME_s1__domainkey_smarthr_jp_6770658a7c1c5a5b9a2bb111813a1ff3" {
  domain = "smarthr.jp"

  name    = "s1._domainkey.smarthr.jp"
  type    = "CNAME"
  ttl     = "1"
  proxied = "false"

  value = "s1.domainkey.u2787976.wl227.sendgrid.net"
}

resource "cloudflare_record" "CNAME_s2__domainkey_smarthr_jp_89513fd40d16a9cb6ad0c987432c0de2" {
  domain = "smarthr.jp"

  name    = "s2._domainkey.smarthr.jp"
  type    = "CNAME"
  ttl     = "1"
  proxied = "false"

  value = "s2.domainkey.u2787976.wl227.sendgrid.net"
}

resource "cloudflare_record" "CNAME_asterisk_smarthr_jp_37b29c23dd0aa517486e67cd6df5bc03" {
  domain = "smarthr.jp"

  name    = "*.smarthr.jp"
  type    = "CNAME"
  ttl     = "1"
  proxied = "false"

  value = "hanica-prod-app.ap-northeast-1.elasticbeanstalk.com"
}

resource "cloudflare_record" "CNAME_soroban_smarthr_jp_2995fefbfa3b8df0b975734a261d3c20" {
  domain = "smarthr.jp"

  name    = "soroban.smarthr.jp"
  type    = "CNAME"
  ttl     = "1"
  proxied = "false"

  value = "current-stork-hckh3bq5y8phnn9nraugmy4g.herokudns.com"
}

resource "cloudflare_record" "CNAME_success_smarthr_jp_f526fc8f3593106caa1f2f1dc1c8885b" {
  domain = "smarthr.jp"

  name    = "success.smarthr.jp"
  type    = "CNAME"
  ttl     = "1"
  proxied = "false"

  value = "mkto-ab220095.com"
}

resource "cloudflare_record" "CNAME_tech_smarthr_jp_0bd5b471b3fe2d80d32c3454a49171b4" {
  domain = "smarthr.jp"

  name    = "tech.smarthr.jp"
  type    = "CNAME"
  ttl     = "1"
  proxied = "false"

  value = "hatenablog.com"
}

resource "cloudflare_record" "CNAME_www_smarthr_jp_e394c5eec3c2a7d41d2d9e058a39edbf" {
  domain = "smarthr.jp"

  name    = "www.smarthr.jp"
  type    = "CNAME"
  ttl     = "1"
  proxied = "true"

  value = "smarthr.jp"
}

resource "cloudflare_record" "MX_cs_smarthr_jp_a8828995bc4ca1df388539979d1db521" {
  domain = "smarthr.jp"

  name    = "cs.smarthr.jp"
  type    = "MX"
  ttl     = "1"
  proxied = "false"

  priority = "10"

  value = "mxa.mailgun.org"
}

resource "cloudflare_record" "MX_cs_smarthr_jp_8b3b65fbccb41b6ecfca55dc160471a0" {
  domain = "smarthr.jp"

  name    = "cs.smarthr.jp"
  type    = "MX"
  ttl     = "1"
  proxied = "false"

  priority = "10"

  value = "mxb.mailgun.org"
}

resource "cloudflare_record" "MX_smarthr_jp_8c622f0d91e77b04065bdea9a8a26415" {
  domain = "smarthr.jp"

  name    = "smarthr.jp"
  type    = "MX"
  ttl     = "1"
  proxied = "false"

  priority = "5"

  value = "alt1.aspmx.l.google.com"
}

resource "cloudflare_record" "MX_smarthr_jp_1dd5a593285b187ff44220aef6a49cf9" {
  domain = "smarthr.jp"

  name    = "smarthr.jp"
  type    = "MX"
  ttl     = "1"
  proxied = "false"

  priority = "5"

  value = "alt2.aspmx.l.google.com"
}

resource "cloudflare_record" "MX_smarthr_jp_1d45aa8d60d9ce5a44a0b6deb209df82" {
  domain = "smarthr.jp"

  name    = "smarthr.jp"
  type    = "MX"
  ttl     = "1"
  proxied = "false"

  priority = "10"

  value = "alt3.aspmx.l.google.com"
}

resource "cloudflare_record" "MX_smarthr_jp_5a230090df1de08468dabc98b77aaa90" {
  domain = "smarthr.jp"

  name    = "smarthr.jp"
  type    = "MX"
  ttl     = "1"
  proxied = "false"

  priority = "10"

  value = "alt4.aspmx.l.google.com"
}

resource "cloudflare_record" "MX_smarthr_jp_2544abf3faf42ce1a62481a1e5dfcd7d" {
  domain = "smarthr.jp"

  name    = "smarthr.jp"
  type    = "MX"
  ttl     = "1"
  proxied = "false"

  priority = "1"

  value = "aspmx.l.google.com"
}

resource "cloudflare_record" "TXT_m1__domainkey_smarthr_jp_7c1cc8626029ce8a632412e09608fa9b" {
  domain = "smarthr.jp"

  name    = "m1._domainkey.smarthr.jp"
  type    = "TXT"
  ttl     = "1"
  proxied = "false"

  value = "v=DKIM1;k=rsa;p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCUMniujh1X0S0c0Ujf/UyACMkvQfkrBpN7vlonzPEbk12T4U83swCaqeKiHWJoLfnHzWc/Gyoaazd2Fo2yZBs/ximtqmVFLbTs2Sn5e4Q2CB1STc2dJYR1J9q6Wo+Hk9dXooZB/j1GFsg1lJlOajzLyrmNRiFg8G2VUZLWYtaJPQIDAQAB"
}

resource "cloudflare_record" "TXT_smarthr_jp_702bcd5a43efef980c6097ad29f0f5a6" {
  domain = "smarthr.jp"

  name    = "smarthr.jp"
  type    = "TXT"
  ttl     = "1"
  proxied = "false"

  value = "google-site-verification=H_4Xzz8vDzjNoCyuJyo5EmkAOTTt-E5Hg3BULxNnzMQ"
}

resource "cloudflare_record" "TXT_smarthr_jp_888e081ceb7bf635f5f1d749cc48b92c" {
  domain = "smarthr.jp"

  name    = "smarthr.jp"
  type    = "TXT"
  ttl     = "1"
  proxied = "false"

  value = "v=spf1 include:servers.mcsv.net include:mktomail.com mx ip4:64.79.155.0/24 ip4:207.218.90.0/24 -all"
}

resource "cloudflare_zone_settings_override" "84e0a4b3e2c4524d58f3c86efa49eaa2" {
  name = "smarthr.jp"

  settings {
    advanced_ddos            = "on"
    always_online            = "on"
    always_use_https         = "on"
    automatic_https_rewrites = "on"
    brotli                   = "on"
    browser_cache_ttl        = 14400
    browser_check            = "on"
    cache_level              = "aggressive"
    challenge_ttl            = 1800
    cname_flattening         = "flatten_at_root"
    development_mode         = "off"
    edge_cache_ttl           = 7200
    email_obfuscation        = "on"
    hotlink_protection       = "off"
    http2                    = "on"
    ip_geolocation           = "on"
    ipv6                     = "on"
    max_upload               = 100
    min_tls_version          = "1.2"

    minify {
      css  = "on"
      html = "on"
      js   = "on"
    }

    mirage = "on"

    mobile_redirect {
      mobile_subdomain = ""
      status           = "off"
      strip_uri        = false
    }

    opportunistic_encryption    = "off"
    opportunistic_onion         = "on"
    origin_error_page_pass_thru = "off"
    polish                      = "lossless"
    prefetch_preload            = "off"
    privacy_pass                = "on"
    pseudo_ipv4                 = "off"
    response_buffering          = "off"
    rocket_loader               = "on"

    security_header {
      enabled            = true
      include_subdomains = true
      max_age            = 0
      nosniff            = false
      preload            = false
    }

    security_level              = "medium"
    server_side_exclude         = "on"
    sha1_support                = "off"
    sort_query_string_for_cache = "off"
    ssl                         = "strict"
    tls_1_2_only                = "off"
    tls_1_3                     = "on"
    tls_client_auth             = "off"
    true_client_ip_header       = "off"
    waf                         = "on"
    webp                        = "off"
    websockets                  = "on"
  }
}
