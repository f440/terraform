resource "heroku_app" "temari-qa" {
  name   = "temari-qa"
  region = "us"
  stack  = "heroku-16"

  organization {
    name   = "smarthr"
    locked = true
  }

  sensitive_config_vars = {
    LANG                     = "en_US.UTF-8"
    RAILS_ENV                = "staging"
    RACK_ENV                 = "staging"
    RAILS_LOG_TO_STDOUT      = true
    RAILS_SERVE_STATIC_FILES = true
    TZ                       = "Asia/Tokyo"
  }

  buildpacks = [
    "heroku/ruby",
  ]
}

resource "heroku_addon" "temari-qa-postgresql" {
  app  = heroku_app.temari-qa.name
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_addon" "temari-qa-redis" {
  app  = heroku_app.temari-qa.name
  plan = "heroku-redis:hobby-dev"
}

resource "heroku_addon" "temari-qa-redis-papertrail" {
  app  = heroku_app.temari-qa.name
  plan = "papertrail:choklad"
}

resource "heroku_pipeline" "temari" {
  name = "temari"
}

resource "heroku_pipeline_coupling" "temari-qa" {
  app      = heroku_app.temari-qa.name
  pipeline = heroku_pipeline.temari.id
  stage    = "staging"
}

