##################################################
#
# staging
#
##################################################
resource "heroku_app" "shittori-staging" {
  name   = "shittori-staging"
  region = "us"
  stack = "heroku-18"
  acm = true

  organization {
    name = "smarthr"
    locked   = false
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

resource "heroku_addon" "shittori-staging-postgresql" {
  app  = "${heroku_app.shittori-staging.name}"
  plan = "heroku-postgresql:hobby-basic"
}

resource "heroku_addon" "shittori-staging-redis" {
  app  = "${heroku_app.shittori-staging.name}"
  plan = "heroku-redis:hobby-dev"
}

resource "heroku_addon" "shittori-staging-papertrail" {
  app  = "${heroku_app.shittori-staging.name}"
  plan = "papertrail:choklad"
}

##################################################
#
# production
#
##################################################
resource "heroku_app" "shittori-production" {
  name   = "shittori-production"
  space = "smarthr-tokyo"
  region = "tokyo"
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

resource "heroku_addon" "shittori-production-papertrail" {
  app  = "${heroku_app.shittori-production.name}"
  plan = "papertrail:fixa"
}

resource "heroku_addon" "shittori-production-scout" {
  app  = "${heroku_app.shittori-production.name}"
  plan = "scout:chair"
}

##################################################
#
# pipeline
#
##################################################
resource "heroku_pipeline" "shittori" {
  name = "shittori"
}

resource "heroku_pipeline_coupling" "shittori-staging" {
  app      = "${heroku_app.shittori-staging.name}"
  pipeline = "${heroku_pipeline.shittori.id}"
  stage    = "staging"
}

resource "heroku_pipeline_coupling" "shittori-production" {
  app      = "${heroku_app.shittori-production.name}"
  pipeline = "${heroku_pipeline.shittori.id}"
  stage    = "production"
}
