/* Load balancer */
resource "aws_elb" "swarm-cluster-elb" {
  name            = "swarm-cluster-ELB"
  subnets         = ["${aws_subnet.swarm-pub-subnet.id}"]
  security_groups = ["${aws_security_group.elb_sg.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:80"
    interval            = 30
  }

  instances = ["${aws_instance.swarm-manager.*.id}", "${aws_instance.swarm-worker.*.id}"]

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "swarm-cluster-elb"
  }
}
