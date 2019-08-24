resource "aws_elb" "elb" {
  name   = "${var.environment}-${var.host_type}"
  subnets = [ "${aws_subnet.main.*.id}" ]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  security_groups = [ "${aws_security_group.elb_sg.id}" ]
  internal = true

  listener {
    instance_port     = 8080
    instance_protocol = "TCP"
    lb_port           = 8080
    lb_protocol       = "TCP"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:8080"
    interval            = 30
  }

  tags {
    Name        = "${var.environment}_${var.host_type}"
    environment = "${var.environment}"
    host_type   = "${var.host_type}"
  }

}

resource "aws_elb_attachment" "instance" {
  count = "${var.ec2_count}"
  elb      = "${aws_elb.elb.id}"
  instance = "${element(aws_instance.instance.*.id, count.index)}"
}