output "public_ip_of_demo_server" {
    description = "これはパブリックIPです"
    value = aws_instance.demo-server.public_ip
}

output "private_ip_of_demo_server" {
    description = "これはプライベートIPです"
    # value = aws_instance.demo_server.private_ip
    value = aws_instance.demo-server.private_ip
}