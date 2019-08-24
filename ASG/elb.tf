resource "aws_elb" "elb" {
  name               = "${var.elb["name"]}"
  subnets = "${split( "," , var.elb["subnet"])}"
  cross_zone_load_balancing   = "${var.elb["enable_cross_zone_load_balancing"]}"
  idle_timeout                = "${var.elb["idle_timeout"]}"
  security_groups = [ "${aws_security_group.elb_sg.id}" ]
  internal = "${var.elb["internal"]}"

  listener {
    instance_port     = "${var.elb["instance_port"]}"
    instance_protocol = "${var.elb["instance_protocol"]}"
    lb_port           = "${var.elb["lb_port"]}"
    lb_protocol       = "${var.elb["lb_protocol"]}"
  }

  health_check {
    healthy_threshold   = "${var.elb["healthy_threshold"]}"
    unhealthy_threshold = "${var.elb["unhealthy_threshold"]}"
    timeout             = "${var.elb["timeout"]}"
    target              = "${var.elb["target"]}"
    interval            = "${var.elb["interval"]}"
  }

  tags {
    Name        = "${var.environment}_${var.host_type}"
    environment = "${var.environment}"
    host_type   = "${var.host_type}"
  }

}