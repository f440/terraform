##################################################
#
# staging
#
##################################################
resource "heroku_app" "ayatori-staging" {
  name   = "ayatori-staging"
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

resource "heroku_addon" "ayatori-staging-postgresql" {
  app  = "${heroku_app.ayatori-staging.name}"
  plan = "heroku-postgresql:hobby-basic"
}

resource "heroku_addon" "ayatori-staging-redis" {
  app  = "${heroku_app.ayatori-staging.name}"
  plan = "heroku-redis:hobby-dev"
}

resource "heroku_addon" "ayatori-staging-papertrail" {
  app  = "${heroku_app.ayatori-staging.name}"
  plan = "papertrail:choklad"
}

##################################################
#
# production
#
##################################################
resource "heroku_app" "ayatori-production" {
  name   = "ayatori-production"
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

resource "heroku_addon" "ayatori-production-papertrail" {
  app  = "${heroku_app.ayatori-production.name}"
  plan = "papertrail:fixa"
}

##################################################
#
# pipeline
#
##################################################
resource "heroku_pipeline" "ayatori" {
  name = "ayatori"
}

resource "heroku_pipeline_coupling" "ayatori-staging" {
  app      = "${heroku_app.ayatori-staging.name}"
  pipeline = "${heroku_pipeline.ayatori.id}"
  stage    = "staging"
}

resource "heroku_pipeline_coupling" "ayatori-production" {
  app      = "${heroku_app.ayatori-production.name}"
  pipeline = "${heroku_pipeline.ayatori.id}"
  stage    = "production"
}
