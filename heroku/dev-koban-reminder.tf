##################################################
#
# staging
#
##################################################
resource "heroku_app" "dev-koban-reminder-staging" {
  name   = "dev-koban-reminder-staging"
  region = "us"
  stack  = "heroku-18"
  acm    = false

  organization {
    name   = "smarthr"
    locked = true
  }

  sensitive_config_vars = {
    LANG                     = "en_US.UTF-8"
    TZ                       = "Asia/Tokyo"
  }

  buildpacks = [
    "heroku/ruby",
  ]
}

resource "heroku_addon" "dev-koban-reminder-staging-scheduler" {
  app  = heroku_app.dev-koban-reminder-staging.name
  plan = "scheduler:standard"
}

resource "heroku_addon" "dev-koban-reminder-staging-papertrail" {
  app  = heroku_app.dev-koban-reminder-staging.name
  plan = "papertrail:choklad"
}

##################################################
#
# pipeline
#
##################################################
resource "heroku_pipeline" "dev-koban-reminder" {
  name = "dev-koban-reminder"
}

resource "heroku_pipeline_coupling" "dev-koban-reminder" {
  app      = heroku_app.dev-koban-reminder-staging.name
  pipeline = heroku_pipeline.dev-koban-reminder.id
  stage    = "staging"
}
