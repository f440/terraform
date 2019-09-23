data "template_file" "kiban-service-fivetran" {
  template = "${file("./files/ec2/user-data/kiban-service-fivetran.cfg.tpl")}"
}

data "template_cloudinit_config" "kiban-service-fivetran" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content      = "${data.template_file.kiban-service-fivetran.rendered}"
  }
}
