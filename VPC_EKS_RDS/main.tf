module "vpc" {
    source = "./vpc"
    vpc_cidr = "10.0.0.0/16"
    environment = "production"
    group_id = "prod-2"
    subnet_cidr = ["10.0.1.0/24", "10.0.2.0/24" ]
    availability_zone = ["us-east-1a", "us-east-1b", "us-east-1c"]
}



module "aurora" {
    source = "./rds"
    identifier_prefix               = "test-aurora"
    engine                          = "aurora"
    engine_version                  = "5.6.10a"
    vpc_id                          = "${module.vpc_id}"
    subnets                         = "${module.subnet_ids}"
    allowed_cidr_blocks             = []"10.0.0.0/16"]
    instance_type                   = "db.r4.large"
    apply_immediately               = true
    db_parameter_group_name         = "default"
    db_cluster_parameter_group_name = "default"
    environment = "production"
    group_id = "prod-2"
}