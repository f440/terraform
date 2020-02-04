resource "cloudflare_zone" "tfer--staging-002D-smarthr-002D-lp-002E-com" {
  paused = "false"
  plan   = "free"
  type   = "full"
  zone   = "staging-smarthr-lp.com"
}

resource "cloudflare_record" "tfer--A_staging-002D-smarthr-002D-lp-002E-com_32998fcfa65a02678db2ee4e7a71ffc5" {
  domain   = "staging-smarthr-lp.com"
  name     = "renewal201904.staging-smarthr-lp.com"
  priority = "0"
  proxied  = "true"
  ttl      = "1"
  type     = "A"
  value    = "157.7.188.212"
}

resource "cloudflare_record" "tfer--A_staging-002D-smarthr-002D-lp-002E-com_86265612f80747e0fc3121dde0380930" {
  domain   = "staging-smarthr-lp.com"
  name     = "corporate.staging-smarthr-lp.com"
  priority = "0"
  proxied  = "true"
  ttl      = "1"
  type     = "A"
  value    = "157.7.188.212"
}

resource "cloudflare_record" "tfer--A_staging-002D-smarthr-002D-lp-002E-com_8d0514c9dc24af27eba0ab5a5412ed5a" {
  domain   = "staging-smarthr-lp.com"
  name     = "staging-smarthr-lp.com"
  priority = "0"
  proxied  = "true"
  ttl      = "1"
  type     = "A"
  value    = "157.7.188.212"
}

resource "cloudflare_record" "tfer--A_staging-002D-smarthr-002D-lp-002E-com_d29ed7abae8789cd32ab9aa706eee90b" {
  domain   = "staging-smarthr-lp.com"
  name     = "mag.staging-smarthr-lp.com"
  priority = "0"
  proxied  = "true"
  ttl      = "1"
  type     = "A"
  value    = "157.7.188.212"
}

# NOTE: cf-terraforming でインポートした設定。
#       zone_settings_overrideリソースは、現状terraform importがサポートされていないため、
#       余計な設定変更をしないようにコメントアウト。
#       今後何かゾーン設定を変更する際に利用する
#resource "cloudflare_zone_settings_override" "zone_settings_override_bad08f44168e5eb55cf960d1757f2fa0" {
#  name = "staging-smarthr-lp.com"
#  settings {
#    #zero_rtt                 = "off"
#    #advanced_ddos            = "on"
#    always_online            = "off"
#    always_use_https         = "on"
#    automatic_https_rewrites = "on"
#    brotli                   = "on"
#    browser_cache_ttl        = 0
#    browser_check            = "on"
#    cache_level              = "basic"
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
#    opportunistic_encryption    = "on"
#    opportunistic_onion         = "on"
#    origin_error_page_pass_thru = "off"
#    polish                      = "off"
#    prefetch_preload            = "off"
#    privacy_pass                = "on"
#    pseudo_ipv4                 = "off"
#    response_buffering          = "off"
#    rocket_loader               = "on"
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
#    ssl                         = "flexible"
#    tls_1_2_only                = "off"
#    tls_1_3                     = "on"
#    tls_client_auth             = "off"
#    true_client_ip_header       = "off"
#    waf                         = "off"
#    webp                        = "off"
#    websockets                  = "on"
#  }
#}
#
