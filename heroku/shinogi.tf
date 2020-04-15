##################################################
#
# staging
#
##################################################
resource "heroku_app" "shinogi-staging" {
  name   = "shinogi-staging"
  region = "us"
  stack  = "heroku-18"
  acm    = false

  organization {
    name   = "smarthr"
    locked = true
  }

  sensitive_config_vars = {
    LANG                     = "en_US.UTF-8"
    MAINTENANCE_PAGE_URL     = "https://smarthr-maintenance.s3-ap-northeast-1.amazonaws.com/503.html"
    RAILS_ENV                = "production"
    RACK_ENV                 = "production"
    RAILS_LOG_TO_STDOUT      = true
    RAILS_SERVE_STATIC_FILES = true
    TZ                       = "Asia/Tokyo"
  }

  buildpacks = [
    "heroku/nodejs",
    "heroku/ruby",
  ]
}

resource "heroku_addon" "shinogi-staging-postgresql" {
  app  = heroku_app.shinogi-staging.name
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_addon" "shinogi-staging-redis" {
  app  = heroku_app.shinogi-staging.name
  plan = "heroku-redis:hobby-dev"
}

resource "heroku_addon" "shinogi-staging-papertrail" {
  app  = heroku_app.shinogi-staging.name
  plan = "papertrail:choklad"
}
##################################################
#
# pipeline
#
##################################################
resource "heroku_pipeline" "shinogi" {
  name = "shinogi"
}

resource "heroku_pipeline_coupling" "shinogi-staging" {
  app      = heroku_app.shinogi-staging.name
  pipeline = heroku_pipeline.shinogi.id
  stage    = "staging"
}
