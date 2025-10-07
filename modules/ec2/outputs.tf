output "public_ip" {
  value = aws_instance.this.public_ip
}

output "security_group_id" {
  description = "The ID of the EC2 security group"
  value       = aws_security_group.ec2_sg.id
}