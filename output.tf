output "ecs_id0" {
  value = alicloud_instance.muayecs[0].id
}

output "ecs_id1" {
  value = alicloud_instance.muayecs[1].id
}

output "vpc_id" {
  value = alicloud_vpc.muay_vpc.id
}

output "rds_id" {
  value = alicloud_db_instance.mysqlmuay.id
}

output "slb_id" {
  value = alicloud_slb.muay_slb.id
}
