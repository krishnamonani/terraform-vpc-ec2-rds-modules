variable "ec2_config" {
  type = object({
    ami           = string
    instance_type = string
    key_name      = string
  })
}


variable "vpc_id" {}
variable "subnet_id" {}
