module "vpc" {
    source = "./vpc"
    vpc_cidr = "10.0.0.0/16"
    environment = "production"
    group_id = "prod-2"
    subnet_cidr = ["10.0.1.0/24", "10.0.2.0/24" ]
    availability_zone = ["us-east-1a", "us-east-1b", "us-east-1c"]
}




