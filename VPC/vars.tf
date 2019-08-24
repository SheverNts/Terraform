variable "vpc_cidr" {
default = "10.0.0.0/16"
}

variable "environment" {
    default="production"
}

variable "host_type" {
    default="application"
}

variable "subnet_cidr" { 
    default=["10.0.1.0/24", "10.0.2.0/24" ]
}
variable "availability_zone" {
  default=["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "ami" {
  default="ami-0080e4c5bc078760e"
}

variable "ec2_count" {
    default=2
}

variable "root_volume_size" {
    default=8
}

variable "instance_type" {
    default="t2.micro"
}


variable "root_volume_type" {
    default="gp2"
}

variable "root_volume_delete_on_termination" {
    default=true
}
