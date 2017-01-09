resource "aws_instance" "swarm-manager" {
  count         = "${var.swarm_managers}"
  ami           = "${lookup(var.aws_docker_amis, var.aws_default_region)}"
  instance_type = "${var.swarm_instance_type}"
  subnet_id     = "${aws_subnet.swarm-pub-subnet.id}"

  tags {
    Name = "swarm-manager-${count.index}"
  }

  vpc_security_group_ids = [
    "${aws_security_group.swarm-cluster.id}",
  ]

  key_name = "${aws_key_pair.deployer_key.key_name}"

  connection {
    user     = "ubuntu"
    key_file = "${var.private_key_path}"
  }

  provisioner "remote-exec" {
    inline = [
      "if ${count.index} == 0; then docker swarm init --advertise-addr ${self.private_ip}; fi",
      "if ${count.index} != 0; then docker swarm join --token ${var.swarm_manager_token} --advertise-addr ${self.private_ip} ${var.swarm_manager_ip}:2377; fi",
      "if ${var.rexray}; then echo \"${data.template_file.rexray.rendered}\" | sudo tee /etc/rexray/config.yml; fi",
      "if ${var.rexray}; then sudo rexray service start >/dev/null 2>/dev/null; fi",
    ]
  }
}
