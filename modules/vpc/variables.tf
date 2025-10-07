variable "vpc_config" {
  type = object({
    region          = string
    cidr_block      = string
    public_subnets  = list(string)
    private_subnets = list(string)
    azs             = list(string)
  })
}
