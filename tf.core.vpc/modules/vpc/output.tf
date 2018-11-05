output "arn" { 
description = "Amazon Resource Name (ARN) of VPC..."
value = "${aws_vpc.myvpc.arn}"
}

output "id" {
description = "The ID of the VPC"
value = "${aws_vpc.myvpc.id}"
}

output "cidr_block" {
description = "The CIDR block of the VPC"
value = "${aws_vpc.myvpc.cidr_block}"
}

output "instance_tenancy" {
description = "Tenancy of instances spin up within VPC."
value = "${aws_vpc.myvpc.instance_tenancy}"
}

output "enable_dns_support" {
description = "Whether or not the VPC has DNS support"
value = "${aws_vpc.myvpc.enable_dns_support}"
}

output "enable_dns_hostnames" {
description =  "Whether or not the VPC has DNS hostname support"
value = "${aws_vpc.myvpc.enable_dns_hostnames}"
}

output "enable_classiclink" {
description = "Whether or not the VPC has Classiclink enabled"
value = "${aws_vpc.myvpc.enable_classiclink}"
}

output "main_route_table_id" {
description =  "The ID of the main route table associated with this VPC. Note that you can change a VPC's main route table by using an aws_main_route_table_association."
value = "${aws_vpc.myvpc.main_route_table_id}"
}

output "default_network_acl_id" {
description =  "The ID of the network ACL created by default on VPC creation"
value = "${aws_vpc.myvpc.default_network_acl_id}"
}

output "default_security_group_id" {
description =  "The ID of the security group created by default on VPC creation"
value = "${aws_vpc.myvpc.default_security_group_id}"
}
output "default_route_table_id" {
description =  "The ID of the route table created by default on VPC creation"
value = "${aws_vpc.myvpc.default_route_table_id}"
}