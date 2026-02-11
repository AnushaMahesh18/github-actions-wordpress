output "instance_ip_addr" {
  value = aws_instance.wordpress_ec2.private_ip
}

output "public_ip" {
  value = aws_instance.wordpress_ec2.public_ip
}
