resource "cloudflare_zone" "tfer--smarthr-002E-jp" {
  paused = "false"
  plan   = "business"
  type   = "full"
  zone   = "smarthr.jp"
}

resource "cloudflare_record" "tfer--A_smarthr-002E-jp_1278c81e13c9ae674dcd04653bbf9c10" {
  domain   = "smarthr.jp"
  name     = "mag.smarthr.jp"
  priority = "0"
  proxied  = "true"
  ttl      = "1"
  type     = "A"
  value    = "150.95.225.254"
}

resource "cloudflare_record" "tfer--A_smarthr-002E-jp_8023f92aa827a480911618ac77156c9a" {
  domain   = "smarthr.jp"
  name     = "smarthr.jp"
  priority = "0"
  proxied  = "true"
  ttl      = "1"
  type     = "A"
  value    = "133.130.16.158"
}

resource "cloudflare_record" "tfer--A_smarthr-002E-jp_9a341f9986d9898ec50797907ec0b034" {
  domain   = "smarthr.jp"
  name     = "o1.sg.smarthr.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "A"
  value    = "168.245.113.131"
}

resource "cloudflare_record" "tfer--CAA_smarthr-002E-jp_29d63c23cb6586af86dcaca8498dde08" {
  data = {
    flags = "0"
    tag   = "issuewild"
    value = "amazon.com"
  }
  domain   = "smarthr.jp"
  name     = "*.smarthr.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CAA"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-jp_025f2e1d4ef08d46cddec630a13362f5" {
  domain   = "smarthr.jp"
  name     = "success.smarthr.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CNAME"
  value    = "mkto-ab220095.com"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-jp_0885b2c01f19ae637acabb0a6f974724" {
  domain   = "smarthr.jp"
  name     = "*.event.smarthr.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CNAME"
  value    = "secure.pageserve.co"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-jp_1386dc8a170acb13493cad4562cac822" {
  domain   = "smarthr.jp"
  name     = "email.cs.smarthr.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CNAME"
  value    = "mailgun.org"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-jp_141e5b2db3d25452b92f0279a49e22d5" {
  domain   = "smarthr.jp"
  name     = "soroban.smarthr.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CNAME"
  value    = "current-stork-hckh3bq5y8phnn9nraugmy4g.herokudns.com"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-jp_1679b67b796f8b5536824e0c1c66032a" {
  domain   = "smarthr.jp"
  name     = "0e2ec3229d46ff2dbc9d2240f2cc8b44.smarthr.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CNAME"
  value    = "verify.bing.com"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-jp_31a7f6a091bef57135e319692cfc2685" {
  domain   = "smarthr.jp"
  name     = "tech.smarthr.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CNAME"
  value    = "hatenablog.com"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-jp_443b540b7db309c86d2ce1a444a16c80" {
  domain   = "smarthr.jp"
  name     = "_a8c84229433b1d58185af97e191be56d.smarthr.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CNAME"
  value    = "_71daf99dd13ab372ad5a353dc116cb9b.tljzshvwok.acm-validations.aws"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-jp_862b536aaf1cfeff0e23e6eefafe7cdb" {
  domain   = "smarthr.jp"
  name     = "*.smarthr.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CNAME"
  value    = "hanica-prod-app.ap-northeast-1.elasticbeanstalk.com"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-jp_95df383104f4b6647cb17bdd455e3124" {
  domain   = "smarthr.jp"
  name     = "k1._domainkey.smarthr.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CNAME"
  value    = "dkim.mcsv.net"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-jp_a4a50f6669eeb155d8cd34d4352a07bf" {
  domain   = "smarthr.jp"
  name     = "envy.smarthr.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CNAME"
  value    = "envy.smarthr.jp.herokudns.com"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-jp_b1ca2d0f7e38ad5c2ea11a1a5ba3d38d" {
  domain   = "smarthr.jp"
  name     = "intercom._domainkey.smarthr.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CNAME"
  value    = "a997f72a-4d4a-4fde-bef1-95bbd6b6c643.dkim.intercom.io"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-jp_bc4fcae0833e107875e07af818906b17" {
  domain   = "smarthr.jp"
  name     = "developer.smarthr.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CNAME"
  value    = "d1221gzek7j9eo.cloudfront.net"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-jp_c40a9583d0080213e698a0fd77a0b1a0" {
  domain   = "smarthr.jp"
  name     = "knowledge.smarthr.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CNAME"
  value    = "smarthrhelp.zendesk.com"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-jp_d5efdf949d772dfc54738f7f2fb1522e" {
  domain   = "smarthr.jp"
  name     = "www.smarthr.jp"
  priority = "0"
  proxied  = "true"
  ttl      = "1"
  type     = "CNAME"
  value    = "smarthr.jp"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-jp_d7195053af3363e5ac2f244ec18c067f" {
  domain   = "smarthr.jp"
  name     = "em.smarthr.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CNAME"
  value    = "u2787976.wl227.sendgrid.net"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-jp_e303c7c59eee97eca4f8c5c720398cc5" {
  domain   = "smarthr.jp"
  name     = "payment.smarthr.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CNAME"
  value    = "payment.smarthr.jp.herokudns.com"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-jp_f06ff6c65cfcf8166ab78d7cae0c8b4a" {
  domain   = "smarthr.jp"
  name     = "s2._domainkey.smarthr.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CNAME"
  value    = "s2.domainkey.u2787976.wl227.sendgrid.net"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-jp_fc48c42f8b124c7bf9eb59df1783cd7c" {
  domain   = "smarthr.jp"
  name     = "s1._domainkey.smarthr.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CNAME"
  value    = "s1.domainkey.u2787976.wl227.sendgrid.net"
}

resource "cloudflare_record" "tfer--MX_smarthr-002E-jp_1d2ac66e8292f102eebff57d520ff143" {
  domain   = "smarthr.jp"
  name     = "cs.smarthr.jp"
  priority = "10"
  proxied  = "false"
  ttl      = "1"
  type     = "MX"
  value    = "mxb.mailgun.org"
}

resource "cloudflare_record" "tfer--MX_smarthr-002E-jp_24ae5d0ba40d385cc8ce8cb40f9ce54e" {
  domain   = "smarthr.jp"
  name     = "smarthr.jp"
  priority = "5"
  proxied  = "false"
  ttl      = "1"
  type     = "MX"
  value    = "alt2.aspmx.l.google.com"
}

resource "cloudflare_record" "tfer--MX_smarthr-002E-jp_2f87bfad05062e55f0bbec027dfba381" {
  domain   = "smarthr.jp"
  name     = "smarthr.jp"
  priority = "10"
  proxied  = "false"
  ttl      = "1"
  type     = "MX"
  value    = "alt3.aspmx.l.google.com"
}

resource "cloudflare_record" "tfer--MX_smarthr-002E-jp_48ff175c987278ef929c0090c2025ed4" {
  domain   = "smarthr.jp"
  name     = "smarthr.jp"
  priority = "5"
  proxied  = "false"
  ttl      = "1"
  type     = "MX"
  value    = "alt1.aspmx.l.google.com"
}

resource "cloudflare_record" "tfer--MX_smarthr-002E-jp_546f48ef7461bbb51fbff6e6e0c05b42" {
  domain   = "smarthr.jp"
  name     = "cs.smarthr.jp"
  priority = "10"
  proxied  = "false"
  ttl      = "1"
  type     = "MX"
  value    = "mxa.mailgun.org"
}

resource "cloudflare_record" "tfer--MX_smarthr-002E-jp_a7ddeff62cf8f84df7a9e327de9b5325" {
  domain   = "smarthr.jp"
  name     = "smarthr.jp"
  priority = "10"
  proxied  = "false"
  ttl      = "1"
  type     = "MX"
  value    = "alt4.aspmx.l.google.com"
}

resource "cloudflare_record" "tfer--MX_smarthr-002E-jp_d8525de4351afb954d85003c64d5bd7f" {
  domain   = "smarthr.jp"
  name     = "smarthr.jp"
  priority = "1"
  proxied  = "false"
  ttl      = "1"
  type     = "MX"
  value    = "aspmx.l.google.com"
}

resource "cloudflare_record" "tfer--TXT_smarthr-002E-jp_126809a38cf7fdbcb6229e000f99845f" {
  domain   = "smarthr.jp"
  name     = "smarthr.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "TXT"
  value    = "v=spf1 include:servers.mcsv.net include:mktomail.com include:u2787976.wl227.sendgrid.net mx ip4:64.79.155.0/24 ip4:207.218.90.0/24 -all"
}

resource "cloudflare_record" "tfer--TXT_smarthr-002E-jp_89188fdcf7927334e0e1fbe50d96d6be" {
  domain   = "smarthr.jp"
  name     = "m1._domainkey.smarthr.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "TXT"
  value    = "v=DKIM1;k=rsa;p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCUMniujh1X0S0c0Ujf/UyACMkvQfkrBpN7vlonzPEbk12T4U83swCaqeKiHWJoLfnHzWc/Gyoaazd2Fo2yZBs/ximtqmVFLbTs2Sn5e4Q2CB1STc2dJYR1J9q6Wo+Hk9dXooZB/j1GFsg1lJlOajzLyrmNRiFg8G2VUZLWYtaJPQIDAQAB"
}

resource "cloudflare_record" "tfer--TXT_smarthr-002E-jp_c3b37bc9970f7a343a3b244baee6553b" {
  domain   = "smarthr.jp"
  name     = "smarthr.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "TXT"
  value    = "google-site-verification=H_4Xzz8vDzjNoCyuJyo5EmkAOTTt-E5Hg3BULxNnzMQ"
}

# NOTE: cf-terraforming でインポートした設定。
#       zone_settings_overrideリソースは、現状terraform importがサポートされていないため、
#       余計な設定変更をしないようにコメントアウト。
#       今後何かゾーン設定を変更する際に利用する
#
#resource "cloudflare_zone_settings_override" "zone_settings_override_84e0a4b3e2c4524d58f3c86efa49eaa2" {
#  name = "smarthr.jp"
#  settings {
#    #zero_rtt                 = "off"
#    #advanced_ddos            = "on"
#    always_online            = "on"
#    always_use_https         = "on"
#    automatic_https_rewrites = "on"
#    brotli                   = "on"
#    browser_cache_ttl        = 14400
#    browser_check            = "on"
#    cache_level              = "aggressive"
#    challenge_ttl            = 1800
#    #ciphers                  = []
#    cname_flattening         = "flatten_at_root"
#    development_mode         = "off"
#    edge_cache_ttl           = 7200
#    email_obfuscation        = "on"
#    hotlink_protection       = "off"
#    http2                    = "on"
#    #http3                    = "off"
#    ip_geolocation           = "on"
#    ipv6                     = "on"
#    max_upload               = 100
#    min_tls_version          = "1.2"
#    minify {
#      css  = "on"
#      html = "on"
#      js   = "on"
#    }
#
#    mirage = "off"
#    mobile_redirect {
#      mobile_subdomain = ""
#      status           = "off"
#      strip_uri        = false
#    }
#
#    opportunistic_encryption    = "off"
#    opportunistic_onion         = "on"
#    origin_error_page_pass_thru = "off"
#    polish                      = "lossless"
#    prefetch_preload            = "off"
#    privacy_pass                = "on"
#    pseudo_ipv4                 = "off"
#    response_buffering          = "off"
#    rocket_loader               = "off"
#    security_header {
#      enabled            = true
#      include_subdomains = true
#      max_age            = 0
#      nosniff            = false
#      preload            = false
#    }
#
#    security_level              = "medium"
#    server_side_exclude         = "on"
#    sort_query_string_for_cache = "off"
#    ssl                         = "strict"
#    tls_1_2_only                = "off"
#    tls_1_3                     = "on"
#    tls_client_auth             = "off"
#    true_client_ip_header       = "off"
#    waf                         = "on"
#    webp                        = "off"
#    websockets                  = "on"
#  }
#}
#
