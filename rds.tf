variable "db_name" {
  default = "mysqldb"
}

variable "db_user_password" {
  default = "P@ssw0rd$NT"
}

variable "db_user_name" {
  default = "muaydb"
}

variable "rds_type" {
  default = "rds.mysql.s2.large"
}

resource "alicloud_db_instance" "mysqlmuay" {
  engine               = "MySQL"
  engine_version       = "8.0"
  instance_type        = var.rds_type
  instance_storage     = "30"
  instance_charge_type = "Postpaid"
  instance_name        = "mysqlmuay"
  vswitch_id           = alicloud_vswitch.muay_vs.id
  monitoring_period    = "60"
  security_ips         = ["0.0.0.0/0"]
}

resource "alicloud_db_account" "account" {
  db_instance_id = alicloud_db_instance.mysqlmuay.id
  account_name        = var.db_user_name
  account_password    = var.db_user_password
}

resource "alicloud_db_database" "database" {
  instance_id = alicloud_db_instance.mysqlmuay.id
  name        = var.db_name
}

resource "alicloud_db_connection" "conn" {
  instance_id       = alicloud_db_instance.mysqlmuay.id

}


resource "alicloud_db_account_privilege" "privilege" {
  instance_id  = alicloud_db_instance.mysqlmuay.id
  account_name = var.db_user_name
  privilege    = "ReadWrite"
  db_names     = [alicloud_db_database.database.name]
}
