resource "aws_vpc" "main" {
  cidr_block = var.vpc_config.cidr_block
  tags = { Name = "modular-vpc" }
}

resource "aws_subnet" "public" {
  for_each = { for idx, cidr in var.vpc_config.public_subnets : idx => cidr }

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = element(var.vpc_config.azs, each.key)
  map_public_ip_on_launch = true

  tags = { Name = "public-subnet-${each.key}" }
}

resource "aws_subnet" "private" {
  for_each = { for idx, cidr in var.vpc_config.private_subnets : idx => cidr }

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = element(var.vpc_config.azs, each.key)

  tags = { Name = "private-subnet-${each.key}" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "vpc-igw" }
}

# Route table for the public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associate the public route table with the public subnets
resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}