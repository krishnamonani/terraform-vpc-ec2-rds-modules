resource "aws_security_group" "rds_sg" {
  name   = "rds-sg"
  vpc_id = var.vpc_id

  ingress {
    description     = "Allow MySQL traffic from the EC2 instance"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.ec2_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-security-group"
  }
}

resource "aws_db_subnet_group" "db_subnet" {
  name       = "modular-db-subnet"
  subnet_ids = var.subnet_ids
  tags       = { Name = "db-subnet-group" }
}

resource "aws_db_instance" "this" {
  allocated_storage      = var.rds_config.allocated_storage
  engine                 = var.rds_config.engine
  engine_version         = var.rds_config.engine_version
  instance_class         = var.rds_config.instance_class
  username               = var.rds_config.username
  password               = var.rds_config.password
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  skip_final_snapshot    = true
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = { Name = "modular-rds" }
}