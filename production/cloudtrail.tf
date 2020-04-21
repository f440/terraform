resource "aws_cloudtrail" "test" {
  name                  = "test"
  s3_bucket_name        = "cloudtrail-test-kufu"
  enable_logging        = false
  is_multi_region_trail = true

  tags = {
    Note = "smarthr-corporateの組織の証跡に集約したため無効化"
  }

}
resource "aws_cloudtrail" "s3-hanica-citus-backup" {
  name                       = "s3-hanica-citus-backup"
  s3_bucket_name             = "cloudtrail-hanica-citus-backup"
  is_multi_region_trail      = true
  enable_logging             = false
  enable_log_file_validation = true

  event_selector {
    include_management_events = true
    read_write_type           = "All"

    data_resource {
      type = "AWS::S3::Object"
      values = [
        "arn:aws:s3",
        "arn:aws:s3:::hanica-citus-backup/",
      ]
    }
  }

  tags = {
    Note = "smarthr-corporateの組織の証跡に集約したため無効化"
  }
}

resource "aws_cloudtrail" "codepipeline-source-trail" {
  name                  = "codepipeline-source-trail"
  s3_bucket_name        = "codepipeline-cloudtrail-placeholder-bucket-ap-northeast-1"
  s3_key_prefix         = "cloud-trail-736134917012-19728a9d-891c-4efa-a667-8ffb9d129b93"
  enable_logging        = false
  is_multi_region_trail = false

  event_selector {
    include_management_events = false
    read_write_type           = "WriteOnly"

    data_resource {
      type = "AWS::S3::Object"
      values = [
        "arn:aws:s3:::oke-production-deploy-config/deploy-config.zip",
      ]
    }
  }

  tags = {
    Note = "smarthr-corporateの組織の証跡に集約したため無効化"
  }
}
