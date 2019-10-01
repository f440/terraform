##################################################
#
# IP
#
##################################################
variable "office-ip" {
  default = "150.249.198.101"
}

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

variable "vpc_subnet_hanica_external_1a_id" {
  default = "subnet-258b5f6c"
}

variable "vpc_subnet_hanica_external_1c_id" {
  default = "subnet-cbe2ec93"
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

##################################################
#
# AMI ID
#
##################################################
variable "kiban-service-fivetran-latest-ami-id" {
  default = "ami-0ff21806645c5e492"
}
