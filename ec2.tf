provider "aws" {
    region = var.location
}

resource "aws_instance" "demo-server" {
    ami                    = var.os_name
    key_name               = var.key
    instance_type          = var.instance-type
    associate_public_ip_address = true
    subnet_id              = aws_subnet.demo_subnet.id
    vpc_security_group_ids = [aws_security_group.demo-vpc-sg.id]
}

resource "aws_vpc" "demo-vpc" {
    cidr_block = var.vpc-cidr
}

// Create Subnet
resource "aws_subnet" "demo_subnet" {
    vpc_id = aws_vpc.demo-vpc.id
    cidr_block = var.subnet1-cidr
    availability_zone = var.subnet_az

    tags = {
        Name = "demo_subnet"
    }
}

resource "aws_internet_gateway" "demo-igw" {
    vpc_id = aws_vpc.demo-vpc.id

    tags = {
        Name = "demo-igw"
    }
}

resource "aws_route_table" "demo-rt" {
    vpc_id = aws_vpc.demo-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.demo-igw.id
    }
}

resource "aws_route_table_association" "demo_rt_association" {
    subnet_id      = aws_subnet.demo_subnet.id
    route_table_id = aws_route_table.demo-rt.id
}

resource "aws_security_group" "demo-vpc-sg" {
    name        = "demo-vpc-sg"
    description = "Allow TLS inbound traffic"
    vpc_id      = aws_vpc.demo-vpc.id

    tags = {
        Name = "allow_tls"
    }

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

    # tags = {
    #     Name = "Allow_tls"
    # }
}

