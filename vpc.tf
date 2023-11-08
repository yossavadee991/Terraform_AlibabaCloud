variable "vs_zone" {
  default = "ap-southeast-1a"
}

# Create VPC
resource "alicloud_vpc" "muay_vpc" {
  vpc_name   = "muay_vpc"
  cidr_block = "192.168.0.0/16"
}

# Create Vswitch
resource "alicloud_vswitch" "muay_vs" {
  vpc_id            = alicloud_vpc.muay_vpc.id
  cidr_block        = "192.168.0.0/24"
  zone_id = var.vs_zone
}

# Create security group
resource "alicloud_security_group" "default" {
  name        = "terraform-default"
  description = "terraform-default"
  vpc_id      = alicloud_vpc.muay_vpc.id
}

# Create Security group rule
resource "alicloud_security_group_rule" "allow_all_tcp" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.default.id
  cidr_ip           = "0.0.0.0/0"
}
