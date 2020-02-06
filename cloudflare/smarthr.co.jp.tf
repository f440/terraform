resource "cloudflare_zone" "tfer--smarthr-002E-co-002E-jp" {
  paused = "false"
  plan   = "business"
  type   = "full"
  zone   = "smarthr.co.jp"
}

resource "cloudflare_record" "tfer--A_smarthr-002E-co-002E-jp_a08f27558db15715501cac108ba15423" {
  domain   = "smarthr.co.jp"
  name     = "shanaiho.smarthr.co.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "A"
  value    = "52.199.100.148"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-co-002E-jp_03fe3a710928507aee413274ac8d4f60" {
  domain   = "smarthr.co.jp"
  name     = "_0514a1d61a6a47afa59bf47f4d99a06c.smarthr.co.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "120"
  type     = "CNAME"
  value    = "_a0b0a7a3596e84a1a93944ade5a7fcaa.kirrbxfjtw.acm-validations.aws"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-co-002E-jp_09d8ff65c8aad95ae6d535c8ca59695f" {
  domain   = "smarthr.co.jp"
  name     = "zendesk3.smarthr.co.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CNAME"
  value    = "mail3.zendesk.com"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-co-002E-jp_34e353f0ab6b67f5c911e30d64bbc0cf" {
  domain   = "smarthr.co.jp"
  name     = "zendesk4.smarthr.co.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CNAME"
  value    = "mail4.zendesk.com"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-co-002E-jp_38ff602b58470bc4230fb4d18a7c014e" {
  domain   = "smarthr.co.jp"
  name     = "lyncdiscover.smarthr.co.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "3600"
  type     = "CNAME"
  value    = "webdir.online.lync.com"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-co-002E-jp_aeeed592a77ac39b00bb29666ebcba28" {
  domain   = "smarthr.co.jp"
  name     = "zendesk2.smarthr.co.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CNAME"
  value    = "mail2.zendesk.com"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-co-002E-jp_b6a985c8928f0dedd8f179df8c5c0c1b" {
  domain   = "smarthr.co.jp"
  name     = "smarthr.co.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CNAME"
  value    = "mad-mestorf4205.on.getshifter.io"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-co-002E-jp_c2562334270dbe954d77a22283cbad4d" {
  domain   = "smarthr.co.jp"
  name     = "ue3v7tkoinyk.smarthr.co.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CNAME"
  value    = "gv-mgv2n6yufi5kt7.dv.googlehosted.com"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-co-002E-jp_e30c534d7dbd9c185fb075f05c5cacb1" {
  domain   = "smarthr.co.jp"
  name     = "sip.smarthr.co.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "3600"
  type     = "CNAME"
  value    = "sipdir.online.lync.com"
}

resource "cloudflare_record" "tfer--CNAME_smarthr-002E-co-002E-jp_e87780e2c72604d10f8d7ebb054ee75e" {
  domain   = "smarthr.co.jp"
  name     = "zendesk1.smarthr.co.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CNAME"
  value    = "mail1.zendesk.com"
}

resource "cloudflare_record" "tfer--MX_smarthr-002E-co-002E-jp_03aa69201dfbeafadf039519977369bf" {
  domain   = "smarthr.co.jp"
  name     = "smarthr.co.jp"
  priority = "10"
  proxied  = "false"
  ttl      = "1"
  type     = "MX"
  value    = "aspmx2.googlemail.com"
}

resource "cloudflare_record" "tfer--MX_smarthr-002E-co-002E-jp_1258e07c7679cb9c062a641d26b56fbe" {
  domain   = "smarthr.co.jp"
  name     = "smarthr.co.jp"
  priority = "1"
  proxied  = "false"
  ttl      = "1"
  type     = "MX"
  value    = "aspmx.l.google.com"
}

resource "cloudflare_record" "tfer--MX_smarthr-002E-co-002E-jp_71fac2cb8a6662db8fdce47d2de7ac64" {
  domain   = "smarthr.co.jp"
  name     = "smarthr.co.jp"
  priority = "5"
  proxied  = "false"
  ttl      = "1"
  type     = "MX"
  value    = "alt1.aspmx.l.google.com"
}

resource "cloudflare_record" "tfer--MX_smarthr-002E-co-002E-jp_7d9762cb60d6a389556745e0b02bbc1d" {
  domain   = "smarthr.co.jp"
  name     = "smarthr.co.jp"
  priority = "10"
  proxied  = "false"
  ttl      = "1"
  type     = "MX"
  value    = "aspmx3.googlemail.com"
}

resource "cloudflare_record" "tfer--MX_smarthr-002E-co-002E-jp_a39c27dff54a88a0427cd09c880396fb" {
  domain   = "smarthr.co.jp"
  name     = "smarthr.co.jp"
  priority = "5"
  proxied  = "false"
  ttl      = "1"
  type     = "MX"
  value    = "alt2.aspmx.l.google.com"
}

resource "cloudflare_record" "tfer--SRV_smarthr-002E-co-002E-jp_745d2bfacb3e2992b550ec7ed0fdafca" {
  data = {
    name     = "smarthr.co.jp"
    port     = "5061"
    priority = "100"
    proto    = "_tcp"
    service  = "_sipfederationtls"
    target   = "sipfed.online.lync.com"
    weight   = "1"
  }
  domain   = "smarthr.co.jp"
  name     = "_sipfederationtls._tcp.smarthr.co.jp"
  priority = "100"
  proxied  = "false"
  ttl      = "3600"
  type     = "SRV"
}

resource "cloudflare_record" "tfer--SRV_smarthr-002E-co-002E-jp_f0d435d7aab2dbb0a75a0479fdd2323c" {
  data = {
    name     = "smarthr.co.jp"
    port     = "443"
    priority = "100"
    proto    = "_tls"
    service  = "_sip"
    target   = "sipdir.online.lync.com"
    weight   = "1"
  }
  domain   = "smarthr.co.jp"
  name     = "_sip._tls.smarthr.co.jp"
  priority = "100"
  proxied  = "false"
  ttl      = "3600"
  type     = "SRV"
}

resource "cloudflare_record" "tfer--TXT_smarthr-002E-co-002E-jp_3534e99368aa2718d56ca8bd5c1684a0" {
  domain   = "smarthr.co.jp"
  name     = "smarthr._domainkey.smarthr.co.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "TXT"
  value    = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCGcE5c0ONsa0UmTRPIfP7HBESaDlgHIyXN4oM+9uCZzno2yPCoVepu+zT9JOLV0aXYhzHvPF5xJ6i7sAfZQpksHEuWL9AAl8MYIgjdbZ3VstV6BrvgOn9xyI+Q/GOousK5nqOTaq/KPoehcm/itBYb0lt8giw5VTtKonUX1hhwRwIDAQAB"
}

resource "cloudflare_record" "tfer--TXT_smarthr-002E-co-002E-jp_3b8c02160c5806c3e7b514e0ffa793ef" {
  domain   = "smarthr.co.jp"
  name     = "shanaiho.smarthr.co.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "TXT"
  value    = "google-site-verification=9YVgt1_sROulOo5R7J2THaE07u4r2lsssr9gCkffcLI"
}

resource "cloudflare_record" "tfer--TXT_smarthr-002E-co-002E-jp_51bb987b84bdcdaf3a28f00a97211c83" {
  domain   = "smarthr.co.jp"
  name     = "smarthr.co.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "TXT"
  value    = "google-site-verification=xjPWNP88eZtrZ9uPTEPF7DjzT_ITudjnC3PfpnlYJh8"
}

resource "cloudflare_record" "tfer--TXT_smarthr-002E-co-002E-jp_591a1ac1704a07c29571fdfa6a5ab7a0" {
  domain   = "smarthr.co.jp"
  name     = "zendeskverification.smarthr.co.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "TXT"
  value    = "b476494abd22bf62"
}

resource "cloudflare_record" "tfer--TXT_smarthr-002E-co-002E-jp_6baf82ab757d4e55b19ab6a34a9915f2" {
  domain   = "smarthr.co.jp"
  name     = "google._domainkey.smarthr.co.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "TXT"
  value    = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAp7H1KmpNLoCrB9oqhjcoT1y700xIp6FmkrI4txSgthLvgdqoW1nvlpGd6g34WnYAhArrC9JeoGn1++aJf5TO4Tw/QgXkPhsI/HobA5IrzM+Jsfo/hfQhndLHlj886ONU2uMe5LTxM/WT6+wu2EKacYlOb34zRjDOI4UzBHFYKXAbAXSSHblwhnS2X/M0PZRfg3szx5iodEDnTcfhZ6d+A32gTl0Ju4TD02oPdLFNzaTu6PBAuFq4id2NTHJniqrtXfy/ey/UX6O1vuxgrQLwAdqNhldIDnAFbKEjH/mY1X4oS8U7V9dEjphP0WOUKs6CofkLJT7QJXLZgJfyzuW/owIDAQAB"
}

resource "cloudflare_record" "tfer--TXT_smarthr-002E-co-002E-jp_6e9eff13ae02f18a9d81e5db3c6bbb29" {
  domain   = "smarthr.co.jp"
  name     = "_github-challenge-kufu.smarthr.co.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "TXT"
  value    = "bda7bbf6a2"
}

resource "cloudflare_record" "tfer--TXT_smarthr-002E-co-002E-jp_7de52bbc2d94b5cbd74234f33e7c4d2c" {
  domain   = "smarthr.co.jp"
  name     = "smarthr.co.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "TXT"
  value    = "MS=ms20000937"
}

resource "cloudflare_record" "tfer--TXT_smarthr-002E-co-002E-jp_85acc24792b028e08fb0550e7cc48e0e" {
  domain   = "smarthr.co.jp"
  name     = "smarthr.co.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "TXT"
  value    = "v=spf1 include:_spf.google.com include:_spf.salesforce.com include:mail.zendesk.com include:mktomail.com include:servers.mcsv.net ~all"
}

resource "cloudflare_record" "CNAME-k1_domainkey_smarthr_co_jp" {
  domain   = "smarthr.co.jp"
  name     = "k1._domainkey.smarthr.co.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "CNAME"
  value    = "dkim.mcsv.net"
}

resource "cloudflare_record" "TXT-m1_domainkey_smarthr_co_jp" {
  domain   = "smarthr.co.jp"
  name     = "m1._domainkey.smarthr.co.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "TXT"
  value    = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCU0u+WI4xnzvTli1r05TRYXAI9E+ibP8i/3gwen8RZ33/5SYVYkySCCE9SSwMsoUBzjMlaLX7E5bR8qcas1knFSEHLI4ioReV5JWFpsXNNItf7eY8xhEH8XCiYJh5tpP4kN6ityRlWISxLUR19Kr76MChenFK0wkew/vK5l5MKzwIDAQAB"
}

resource "cloudflare_record" "TXT-_dmarc_smarthr_co_jp" {
  domain   = "smarthr.co.jp"
  name     = "_dmarc.smarthr.co.jp"
  priority = "0"
  proxied  = "false"
  ttl      = "1"
  type     = "TXT"
  value    = "v=DMARC1; p=none; rua=mailto:dmarc-report@smarthr.co.jp; ruf=mailto:dmarc-report@smarthr.co.jp"
}

# NOTE: cf-terraforming でインポートした設定。
#       zone_settings_overrideリソースは、現状terraform importがサポートされていないため、
#       余計な設定変更をしないようにコメントアウト。
#       今後何かゾーン設定を変更する際に利用する
#
#resource "cloudflare_zone_settings_override" "zone_settings_override_a930f988bc780d3f9aa71c778da98d00" {
#  name = "smarthr.co.jp"
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
#    polish                      = "off"
#    prefetch_preload            = "off"
#    privacy_pass                = "on"
#    pseudo_ipv4                 = "off"
#    response_buffering          = "off"
#    rocket_loader               = "off"
#    security_header {
#      enabled            = false
#      include_subdomains = false
#      max_age            = 0
#      nosniff            = false
#      preload            = false
#    }
#
#    security_level              = "medium"
#    server_side_exclude         = "on"
#    sort_query_string_for_cache = "off"
#    ssl                         = "full"
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
