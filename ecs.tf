variable "ecs_type" {
  default = "ecs.c5.xlarge"
}

variable "wordpress_image" {
  default = "ubuntu_20_04_x64_20G_alibase_20220524.vhd"
}

variable "ecs_password" {
  default = "P@ssw0rd$NT"
}

# The user_data script for setting up Nginx and WordPress
data "template_file" "setup_script" {
  template = file("${path.module}/setup_wordpress_nginx.sh")
}

resource "alicloud_instance" "muayecs" {
  count                 = 2
  image_id              = var.wordpress_image
  internet_charge_type  = "PayByBandwidth"
  instance_type         = var.ecs_type
  system_disk_category  = "cloud_efficiency"
  security_groups       = [alicloud_security_group.default.id]
  instance_name         = "administrator"
  vswitch_id            = alicloud_vswitch.muay_vs.id
  password              = var.ecs_password
  internet_max_bandwidth_out = 5
  user_data             = data.template_file.setup_script.rendered
}

