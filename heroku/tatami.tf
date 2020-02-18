##################################################
#
# staging
#
##################################################
resource "heroku_app" "tatami-staging" {
  name   = "tatami-staging"
  region = "us"
  stack  = "heroku-18"
  acm    = false

  organization {
    name   = "smarthr"
    locked = false
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
    "heroku/ruby",
    "heroku/nodejs",
  ]
}

resource "heroku_addon" "tatami-staging-redis" {
  app  = heroku_app.tatami-staging.name
  plan = "heroku-redis:premium-0"
}

resource "heroku_addon" "tatami-staging-deployhooks" {
  app  = heroku_app.tatami-staging.name
  plan = "deployhooks:http"
}

resource "heroku_addon" "tatami-staging-papertrail" {
  app  = heroku_app.tatami-staging.name
  plan = "papertrail:choklad"
}

resource "heroku_addon" "tatami-staging-sslfasttrack" {
  app  = heroku_app.tatami-staging.name
  plan = "sslfasttrack:wildcard"
}

##################################################
#
# production
#
##################################################
resource "heroku_app" "tatami-production" {
  name   = "tatami-production"
  space  = "smarthr-tokyo"
  region = "tokyo"
  stack  = "heroku-18"
  acm    = true

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
    "heroku/ruby",
    "heroku/nodejs",
  ]
}

##################################################
#
# pipeline
#
##################################################
resource "heroku_pipeline" "tatami" {
  name = "tatami"
}

resource "heroku_pipeline_coupling" "tatami-staging" {
  app      = heroku_app.tatami-staging.name
  pipeline = heroku_pipeline.tatami.id
  stage    = "staging"
}

resource "heroku_pipeline_coupling" "tatami-production" {
  app      = heroku_app.tatami-production.name
  pipeline = heroku_pipeline.tatami.id
  stage    = "production"
}

