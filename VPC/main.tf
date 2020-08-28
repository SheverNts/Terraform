resource "aws_vpc" "main" {

  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags {
    Name        = "${var.environment}_${var.host_type}"
    environment = "${var.environment}"
    host_type   = "${var.host_type}"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name        = "${var.environment}_${var.host_type}"
    environment = "${var.environment}"
    host_type   = "${var.host_type}"
  }
}


resource "aws_subnet" "main" {
  count = "${length(var.subnet_cidr)}"
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${element(var.subnet_cidr, count.index)}"
  availability_zone = "${element(var.availability_zone, count.index)}"

  tags {
    Name        = "${var.environment}_${var.host_type}"
    environment = "${var.environment}"
    host_type   = "${var.host_type}"
  }
}


resource "aws_route_table" "route" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

tags {
    Name        = "${var.environment}_${var.host_type}"
    environment = "${var.environment}"
    host_type   = "${var.host_type}"
  }
}


resource "aws_route_table_association" "subnet_public" {
  count = "${length(var.subnet_cidr)}"
  subnet_id      = "${element(aws_subnet.main.*.id, count.index)}"
  route_table_id = "${aws_route_table.route.id}"
}

