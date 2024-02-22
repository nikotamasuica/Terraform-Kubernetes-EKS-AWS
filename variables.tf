variable "location" {
    default = "ap-northeast-1"
}

variable "os_name" {
    default = "ami-05a03e6058638183d"
}

variable "key" {
    default = "tf"
}

variable "instance-type" {
    default = "t2.micro"
}

variable "vpc-cidr" {
    default  = "10.10.0.0/16"
}

variable "subnet1-cidr" {
    default  = "10.10.1.0/24"
}

variable "subnet_az" {
    default  = "ap-northeast-1a"
}




