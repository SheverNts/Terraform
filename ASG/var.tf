variable "elb" {
  description = "vars for elb"
  type        = "map"

  default = {
    "idle_timeout"                     = "1800"
    "cross_zone_load_balancing"        = "true"
    "idle_timeout"                     = "400"
    "connection_draining"              = "true"
    "connection_draining_timeout"      = "400"
    "subnet"                           = ""
    "healthy_threshold"                = "2"
    "unhealthy_threshold"              = "2"
    "timeout"                          = "3"
    "target"                           = "TCP:8080"
    "interval"                         = "30"
    "instance_port"                    = "8080"
    "instance_protocol"                = "TCP"
    "lb_port"                          = "8080"
    "lb_protocol"                      = "TCP"
    "name"                             = "app-elb"
    "deletion_protection"              = "true"
    "load_balancer_type"               = "application"
    "internal"                         = "true"
    "enable_cross_zone_load_balancing" = "true"
    "access_log_interval" = "5"
    "name" = "elblive"
  }
}


variable "autoscaling_conf" {
  description = "root block device and instance variabl"
  type        = "map"

  default = {
    "name"                      = "application.example.com"
    "max_size"                  = "7"
    "min_size"                  = "7"
    "health_check_grace_period" = "10"
    "health_check_type"         = "ELB"
    "desired_capacity"          = "7"
    "force_delete"              = "true"
    "subnet"                    = "subnet,subnet"
    "termination_policies"      = "OldestInstance,OldestLaunchConfiguration"
  }
}


variable "launch_conf" {
  description = "root block device and instance variable"
  type        = "map"

  default = {
    "name"                              = "app.example.com"
    "ami"                               = ""
    "instance_type"                     = "t2.micro"
    "iam_instance_profile"              = ""
    "count"                             = "1"
    "disable_api_termination"           = "false"
    "subnet_id"                         = ""
    "version"                           = "2.1"
    "root_volume_type"                  = "gp2"
    "root_volume_size"                  = "8"
    "root_volume_delete_on_termination" = "true"
    "spot_price"                        = "0.1"
  }
}


variable "host_type" {
  description = "host_type tag key"
  default     = ""
}

variable "iam_default" {
  description = "default iam role for instance "
  default     = ""
}

variable "default_key" {
  description = "Default ssh key"
  default     = ""
}

variable "vpc_id" {
  description = "default vpc_id"
  default     = ""
}

variable "aws_region" {
  description = "default aws_region"
  default     = "us-east-1"
}

variable "environment" {
  description = "environment tag key"
  default     = "production"
}
