# NOTE: Terraformではデフォルトベースライン設定ができないので、適用後に手動で設定する。
#       aws ssm register-default-patch-baseline --baseline-id pb-xxxxxxxxxxxxxxxx
resource "aws_ssm_patch_baseline" "ubuntu-security-all" {
  name        = "UbuntuAllSecurityPatchBaseline"
  description = "Patch baseline for ubuntu all security patches"

  operating_system = "UBUNTU"
  approval_rule {
    approve_after_days  = 0
    enable_non_security = false
    patch_filter {
      key    = "PRODUCT"
      values = ["*"]
    }
    patch_filter {
      key    = "SECTION"
      values = ["*"]
    }
    patch_filter {
      key    = "PRIORITY"
      values = ["*"]
    }
  }
}

resource "aws_ssm_patch_baseline" "amazon-security-all" {
  name        = "AmazonLinuxAllSecurityPatchBaseline"
  description = "Patch baseline for Amazon Linux all security patches"

  operating_system = "AMAZON_LINUX"
  approval_rule {
    approve_after_days  = 0
    enable_non_security = false
    patch_filter {
      key    = "PRODUCT"
      values = ["*"]
    }
    patch_filter {
      key    = "CLASSIFICATION"
      values = ["*"]
    }
    patch_filter {
      key    = "SEVERITY"
      values = ["*"]
    }
  }
}

resource "aws_ssm_patch_baseline" "amazon2-security-all" {
  name        = "AmazonLinux2AllSecurityPatchBaseline"
  description = "Patch baseline for Amazon Linux 2 all security patches"

  operating_system = "AMAZON_LINUX_2"
  approval_rule {
    approve_after_days  = 0
    enable_non_security = false
    patch_filter {
      key = "PRODUCT"

      values = ["*"]
    }
    patch_filter {
      key    = "CLASSIFICATION"
      values = ["*"]
    }
    patch_filter {
      key    = "SEVERITY"
      values = ["*"]
    }
  }
}
