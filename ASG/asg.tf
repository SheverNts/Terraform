provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_launch_configuration" "as_conf" {
  name_prefix          = "${var.launch_conf["name"]}"
  image_id             = "${var.launch_conf["ami"]}"
  instance_type        = "${var.launch_conf["instance_type"]}"
  iam_instance_profile = "${var.iam_default}"
  security_groups      = ["${aws_security_group.instance_sg.id}"]

  key_name             = "${var.default_key}"
  #spot_price = "${var.launch_conf["spot_price"]}"

  root_block_device {
    volume_type           = "${var.launch_conf["root_volume_type"]}"
    volume_size           = "${var.launch_conf["root_volume_size"]}"
    delete_on_termination = "${var.launch_conf["root_volume_delete_on_termination"]}"
  }

   lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                      = "${var.autoscaling_conf["name"]}"
  max_size                  = "${var.autoscaling_conf["max_size"]}"
  min_size                  = "${var.autoscaling_conf["min_size"]}"
  health_check_grace_period = "${var.autoscaling_conf["health_check_grace_period"]}"
  health_check_type         = "${var.autoscaling_conf["health_check_type"]}"
  desired_capacity          = "${var.autoscaling_conf["desired_capacity"]}"
  force_delete              = "${var.autoscaling_conf["force_delete"]}"
  launch_configuration      = "${aws_launch_configuration.as_conf.name}"
  vpc_zone_identifier       = "${split( "," , var.autoscaling_conf["subnet"])}"
  load_balancers = [ "${aws_elb.elb.id}" ]
  termination_policies      = "${split( "," , var.autoscaling_conf["termination_policies"])}"

  tags = [
    {
      key                 = "Name"
      value               = "${var.environment}_${var.host_type}"
      propagate_at_launch = true
    },
    {
      key                 = "environment"
      value               = "${var.environment}"
      propagate_at_launch = true
    },
    {
      key                 = "host_type"
      value               = "${var.host_type}"
      propagate_at_launch = true
    }
  ]
}