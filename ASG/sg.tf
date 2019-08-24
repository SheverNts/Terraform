resource "aws_security_group" "instance_sg" {
  name        = "instance_sg"
  description = "security rules for instance"
  vpc_id      = "${var.vpc_id}"

  ingress {
    description = "secure shell "
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol   = 1
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 0
    to_port    = 0
  }

  egress {
    description = "allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow 8080 from instance server to ALB"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    security_groups = [ "${ aws_security_group.elb_sg.id }" ]
  }

  ingress {
    description = "allow from itself"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    self = true
  }

  tags {
    Name        = "${var.environment}_${var.host_type}"
    environment = "${var.environment}"
    host_type   = "${var.host_type}"
  }
}

resource "aws_security_group" "elb_sg" {
  name        = "elb_sg"
  description = "security rules for elb"
  vpc_id      = "${var.vpc_id}"

  ingress {
    description = "allow all icmp inbound traffic"
    protocol   = 1
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 0
    to_port    = 0
  }

  egress {
    description = "allow all icmp outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "all app to external"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.environment}_${var.host_type}"
    environment = "${var.environment}"
    host_type   = "${var.host_type}"
  }
}