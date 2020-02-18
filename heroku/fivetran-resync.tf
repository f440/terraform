##################################################
#
# production
#
##################################################
resource "heroku_app" "fivetran-resync-production" {
  name   = "fivetran-resync-production"
  region = "us"
  stack  = "heroku-18"
  acm    = true

  organization {
    name   = "smarthr"
    locked = true
  }

  sensitive_config_vars = {
    LANG                     = "en_US.UTF-8"
    TZ                       = "Asia/Tokyo"
    NOTIFY_MESSAGE           = "true"
    DELETE_DATASET           = "true"
  }

  buildpacks = [
    "heroku/ruby",
    "https://buildpack-registry.s3.amazonaws.com/buildpacks/heroku/google-chrome.tgz",
    "https://buildpack-registry.s3.amazonaws.com/buildpacks/heroku/chromedriver.tgz"
  ]
}

resource "heroku_addon" "fivetran-resync-production-scheduler" {
  app  = heroku_app.fivetran-resync-production.name
  plan = "scheduler:standard"
}

resource "heroku_addon" "fivetran-resync-production-papertrail" {
  app  = heroku_app.fivetran-resync-production.name
  plan = "papertrail:choklad"
}

##################################################
#
# pipeline
#
##################################################
resource "heroku_pipeline" "fivetran-resync" {
  name = "fivetran-resync"
}

resource "heroku_pipeline_coupling" "fivetran-resync" {
  app      = heroku_app.fivetran-resync-production.name
  pipeline = heroku_pipeline.fivetran-resync.id
  stage    = "production"
}
