resource "aws_key_pair" "terraform_ec2_key" {
  key_name = "ec2_key"
  public_key ="${file("key/public.key")}"
}
resource "aws_instance" "instance" {
  count                   = "${var.ec2_count}"
  ami                     = "${var.ami}"
  instance_type           = "${var.instance_type}"
  vpc_security_group_ids  = ["${aws_security_group.instance_sg.id}"]
  subnet_id               = "${element(aws_subnet.main.*.id, count.index )}"
  key_name = "${aws_key_pair.terraform_ec2_key.key_name}"
  associate_public_ip_address = true

  root_block_device {
    volume_type           = "${var.root_volume_type}"
    volume_size           = "${var.root_volume_size}"
    delete_on_termination = "${var.root_volume_delete_on_termination}"
  }

  volume_tags = {
    Name        = "${var.environment}_${var.host_type}"
    environment = "${var.environment}"
    host_type   = "${var.host_type}"
  }

  tags {
    Name        = "${var.environment}_${var.host_type}"
    environment = "${var.environment}"
    host_type   = "${var.host_type}"
  }

}



