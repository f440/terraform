##################################################
#
# SubnetGroup
#
##################################################
variable "plus_subnet_group_name" {
  default = "hanica-docker-redis-subnet-group"
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
