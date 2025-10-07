resource "aws_security_group" "ec2_sg" {
  name   = "ec2-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "this" {
  ami                         = var.ec2_config.ami
  instance_type               = var.ec2_config.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.ec2_config.key_name
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]

  tags = { Name = "modular-ec2" }
}
