##################################################
#
# staging
#
##################################################
resource "heroku_app" "jougo-staging" {
  name   = "jougo-staging"
  region = "us"
  stack = "heroku-18"
  acm = true

  organization {
    name = "smarthr"
    locked   = true
  }

  sensitive_config_vars = {
    LANG = "en_US.UTF-8"
    MAINTENANCE_PAGE_URL = "https://smarthr-maintenance.s3-ap-northeast-1.amazonaws.com/503.html"
    RAILS_ENV = "production"
    RACK_ENV = "production"
    RAILS_LOG_TO_STDOUT = true
    RAILS_SERVE_STATIC_FILES = true
    TZ = "Asia/Tokyo"
  }

  buildpacks = [
    "heroku/ruby",
  ]
}

resource "heroku_addon" "jougo-staging-postgresql" {
  app  = "${heroku_app.jougo-staging.name}"
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_addon" "jougo-staging-redis" {
  app  = "${heroku_app.jougo-staging.name}"
  plan = "heroku-redis:hobby-dev"
}

resource "heroku_addon" "jougo-staging-papertrail" {
  app  = "${heroku_app.jougo-staging.name}"
  plan = "papertrail:choklad"
}

##################################################
#
# production
#
##################################################
resource "heroku_app" "jougo-production" {
  name   = "jougo-production"
  space = "smarthr-tokyo"
  region = "tokyo"
  stack = "heroku-18"

  organization {
    name = "smarthr"
    locked   = true
  }

  sensitive_config_vars = {
    LANG = "en_US.UTF-8"
    MAINTENANCE_PAGE_URL = "https://smarthr-maintenance.s3-ap-northeast-1.amazonaws.com/503.html"
    RAILS_ENV = "production"
    RACK_ENV = "production"
    RAILS_LOG_TO_STDOUT = true
    RAILS_SERVE_STATIC_FILES = true
    TZ = "Asia/Tokyo"
  }

  buildpacks = [
    "heroku/ruby",
  ]
}

resource "heroku_addon" "jougo-production-papertrail" {
  app  = "${heroku_app.jougo-production.name}"
  plan = "papertrail:choklad"
}

##################################################
#
# pipeline
#
##################################################
resource "heroku_pipeline" "jougo" {
  name = "jougo"
}

resource "heroku_pipeline_coupling" "jougo-staging" {
  app      = "${heroku_app.jougo-staging.name}"
  pipeline = "${heroku_pipeline.jougo.id}"
  stage    = "staging"
}

resource "heroku_pipeline_coupling" "jougo-production" {
  app      = "${heroku_app.jougo-production.name}"
  pipeline = "${heroku_pipeline.jougo.id}"
  stage    = "production"
}
