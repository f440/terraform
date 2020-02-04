data "template_file" "kiban-service-fivetran-koban" {
  template = file("./files/ec2/user-data/kiban-service-fivetran-koban.cfg.tpl")
}

data "template_cloudinit_config" "kiban-service-fivetran-koban" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content      = data.template_file.kiban-service-fivetran-koban.rendered
  }
}

data "template_file" "kiban-service-fivetran-omen" {
  template = file("./files/ec2/user-data/kiban-service-fivetran-omen.cfg.tpl")
}

data "template_cloudinit_config" "kiban-service-fivetran-omen" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content      = data.template_file.kiban-service-fivetran-omen.rendered
  }
}

