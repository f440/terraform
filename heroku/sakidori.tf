##################################################
#
# staging
#
##################################################
resource "heroku_app" "sakidori-pca-dx-staging" {
  name   = "sakidori-pca-dx-staging"
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
    PCA_APP="pay_dx"
    RAILS_ENV = "production"
    RACK_ENV = "production"
    RAILS_LOG_TO_STDOUT = true
    RAILS_SERVE_STATIC_FILES = true
    TZ = "Asia/Tokyo"
  }

  buildpacks = [
    "heroku/ruby",
    "heroku/nodejs"
  ]
}

resource "heroku_addon" "sakidori-pca-dx-staging-postgresql" {
  app  = "${heroku_app.sakidori-pca-dx-staging.name}"
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_addon" "sakidori-pca-dx-staging-redis" {
  app  = "${heroku_app.sakidori-pca-dx-staging.name}"
  plan = "heroku-redis:hobby-dev"
}

resource "heroku_addon" "sakidori-pca-dx-staging-papertrail" {
  app  = "${heroku_app.sakidori-pca-dx-staging.name}"
  plan = "papertrail:choklad"
}

resource "heroku_app" "sakidori-pca-hyper-staging" {
  name   = "sakidori-pca-hyper-staging"
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
    PCA_APP="pay_hyper"
    RAILS_ENV = "production"
    RACK_ENV = "production"
    RAILS_LOG_TO_STDOUT = true
    RAILS_SERVE_STATIC_FILES = true
    TZ = "Asia/Tokyo"
  }

  buildpacks = [
    "heroku/ruby",
    "heroku/nodejs"
  ]
}

resource "heroku_addon" "sakidori-pca-hyper-staging-postgresql" {
  app  = "${heroku_app.sakidori-pca-hyper-staging.name}"
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_addon" "sakidori-pca-hyper-staging-redis" {
  app  = "${heroku_app.sakidori-pca-hyper-staging.name}"
  plan = "heroku-redis:hobby-dev"
}

resource "heroku_addon" "sakidori-pca-hyper-staging-papertrail" {
  app  = "${heroku_app.sakidori-pca-hyper-staging.name}"
  plan = "papertrail:choklad"
}

##################################################
#
# production
#
##################################################
resource "heroku_app" "sakidori-pca-dx-production" {
  name   = "sakidori-pca-dx-production"
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
    PCA_APP="pay_dx"
    RAILS_ENV = "production"
    RACK_ENV = "production"
    RAILS_LOG_TO_STDOUT = true
    RAILS_SERVE_STATIC_FILES = true
    TZ = "Asia/Tokyo"
  }

  buildpacks = [
    "heroku/ruby",
    "heroku/nodejs"
  ]
}

resource "heroku_addon" "sakidori-pca-dx-production-papertrail" {
  app  = "${heroku_app.sakidori-pca-dx-production.name}"
  plan = "papertrail:fixa"
}

resource "heroku_app" "sakidori-pca-hyper-production" {
  name   = "sakidori-pca-hyper-production"
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
    PCA_APP="pay_hyper"
    RAILS_ENV = "production"
    RACK_ENV = "production"
    RAILS_LOG_TO_STDOUT = true
    RAILS_SERVE_STATIC_FILES = true
    TZ = "Asia/Tokyo"
  }

  buildpacks = [
    "heroku/ruby",
    "heroku/nodejs"
  ]
}

resource "heroku_addon" "sakidori-pca-hyper-production-papertrail" {
  app  = "${heroku_app.sakidori-pca-hyper-production.name}"
  plan = "papertrail:fixa"
}

##################################################
#
# pipeline
#
##################################################
resource "heroku_pipeline" "sakidori" {
  name = "sakidori"
}

resource "heroku_pipeline_coupling" "sakidori-pca-dx-staging" {
  app      = "${heroku_app.sakidori-pca-dx-staging.name}"
  pipeline = "${heroku_pipeline.sakidori.id}"
  stage    = "staging"
}

resource "heroku_pipeline_coupling" "sakidori-pca-hyper-staging" {
  app      = "${heroku_app.sakidori-pca-hyper-staging.name}"
  pipeline = "${heroku_pipeline.sakidori.id}"
  stage    = "staging"
}

resource "heroku_pipeline_coupling" "sakidori-pca-dx-production" {
  app      = "${heroku_app.sakidori-pca-dx-production.name}"
  pipeline = "${heroku_pipeline.sakidori.id}"
  stage    = "production"
}

resource "heroku_pipeline_coupling" "sakidori-pca-hyper-production" {
  app      = "${heroku_app.sakidori-pca-hyper-production.name}"
  pipeline = "${heroku_pipeline.sakidori.id}"
  stage    = "production"
}
