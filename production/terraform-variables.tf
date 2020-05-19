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
# Internet Gateway
#
##################################################
variable "hanica-new-igw" {
  default = "igw-43568627"
}

##################################################
#
# NAT Gateway
#
##################################################
variable "hanica-ngw-1a" {
  default = "nat-082042ed299995ecc"
}

variable "hanica-ngw-1c" {
  default = "nat-0c4f7fba08b7ea6bf"
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

variable "hanica-bastion-ami-id" {
  default = "ami-940cdceb"
}

variable "hanica-operation-ami-id" {
  default = "ami-48630c2e"
}

variable "rundeck-ami-id" {
  default = "ami-696b9a16"
}

##################################################
#
# ACM ARN
#
##################################################

variable "acm-wildcard-smarthr-plus-arn" {
  default = "arn:aws:acm:ap-northeast-1:736134917012:certificate/af5335ba-1439-4aae-b351-0e3b7b74c881"
}

##################################################
#
# Route 53 Alias Name
#
##################################################

variable "route53-alias-tatami-production-alb" {
  default = "dualstack.tatami-production-alb-1652781771.ap-northeast-1.elb.amazonaws.com"
}
