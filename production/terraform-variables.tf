##################################################
#
# VPC
#
##################################################
variable "vpc-hanica-new-vpc" {
  default = "vpc-77586713"
}

##################################################
#
# SubnetGroup
#
##################################################
variable "plus_subnet_group_name" {
  default = "hanica-docker-redis-subnet-group"
}

variable "vpc_subnet_hanica_internal_1a_id" {
  default = "subnet-f6b561bf"
}

variable "vpc_subnet_hanica_internal_1c_id" {
  default = "subnet-87e0eedf"
}

##################################################
#
# SecurityGroup
#
##################################################
variable "sg-default" {
  default = "sg-c97f2baf"
}

variable "sg-heroku-ps-redis" {
  default = "sg-0db4aaa18c4522a07"
}

##################################################
#
# ZoneID
#
##################################################
variable "aoyagi_farm_zone_id" {
  default = "Z2R8KLE7JC3PK7"
}

variable "smarthr_plus_zone_id" {
  default = "Z1XLEN8BSTM9ZS"
}
