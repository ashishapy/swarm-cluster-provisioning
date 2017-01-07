data "template_file" "rexray" {
  template = "${file("rexray.tpl")}"

  vars {
    aws_access_key     = "${var.aws_access_key}"
    aws_secret_key     = "${var.aws_secret_key}"
    aws_default_region = "${var.aws_default_region}"
    aws_security_group = "${aws_security_group.swarm-cluster.id}"
  }
}
