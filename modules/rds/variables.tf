variable "rds_config" {
  type = object({
    allocated_storage = number
    engine            = string
    engine_version    = string
    instance_class    = string
    username          = string
    password          = string
  })
}

variable "ec2_security_group_id" {
  description = "The security group ID of the EC2 instance that needs access to the DB"
  type        = string
}

variable "subnet_ids" {}
variable "vpc_id" {}
