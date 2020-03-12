##################################################
#
# staging
#
##################################################
resource "heroku_app" "meyasu-staging" {
  name   = "meyasu-staging"
  space  = "smarthr-tokyo"
  region = "tokyo"
  stack  = "heroku-18"

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
    "heroku/nodejs",
    "heroku/ruby",
  ]
}

resource "heroku_addon" "meyasu-staging-postgresql" {
  app  = heroku_app.meyasu-staging.name
  plan = "heroku-postgresql:standard-0"
}

resource "heroku_addon" "meyasu-staging-redis" {
  app  = heroku_app.meyasu-staging.name
  plan = "heroku-redis:premium-0"
}

resource "heroku_addon" "meyasu-staging-deployhooks" {
  app  = heroku_app.meyasu-staging.name
  plan = "deployhooks:http"
}

resource "heroku_addon" "meyasu-staging-papertrail" {
  app  = heroku_app.meyasu-staging.name
  plan = "papertrail:choklad"
}

##################################################
#
# production
#
##################################################
resource "heroku_app" "meyasu-production" {
  name   = "meyasu-production"
  space  = "smarthr-tokyo"
  region = "tokyo"
  stack  = "heroku-18"

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

##################################################
#
# pipeline
#
##################################################
resource "heroku_pipeline" "meyasu" {
  name = "meyasu"
}

resource "heroku_pipeline_coupling" "meyasu-staging" {
  app      = heroku_app.meyasu-staging.name
  pipeline = heroku_pipeline.meyasu.id
  stage    = "staging"
}

resource "heroku_pipeline_coupling" "meyasu-production" {
  app      = heroku_app.meyasu-production.name
  pipeline = heroku_pipeline.meyasu.id
  stage    = "production"
}

