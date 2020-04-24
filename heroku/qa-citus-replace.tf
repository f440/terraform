##################################################
#
# production
#
##################################################
resource "heroku_app" "qa-citus-replace-production" {
  name   = "qa-citus-replace-production"
  space  = "smarthr-tokyo"
  region = "tokyo"
  stack  = "heroku-18"
  acm    = true

  organization {
    name   = "smarthr"
    locked = false
  }

  sensitive_config_vars = {
    LANG                     = "en_US.UTF-8"
    TZ                       = "Asia/Tokyo"
  }

  buildpacks = [
    "heroku/ruby",
  ]
}

##################################################
#
# pipeline
#
##################################################
resource "heroku_pipeline" "qa-citus-replace" {
  name = "qa-citus-replace"
}

resource "heroku_pipeline_coupling" "qa-citus-replace-production" {
  app      = heroku_app.qa-citus-replace-production.name
  pipeline = heroku_pipeline.qa-citus-replace.id
  stage    = "production"
}

