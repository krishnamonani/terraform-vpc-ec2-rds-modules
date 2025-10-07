variable "vpc_config" {
  type = object({
    region          = string
    cidr_block      = string
    public_subnets  = list(string)
    private_subnets = list(string)
    azs             = list(string)
  })
}

variable "ec2_config" {
  type = object({
    ami           = string
    instance_type = string
    key_name      = string
  })
}

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
