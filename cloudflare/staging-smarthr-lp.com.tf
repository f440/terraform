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

