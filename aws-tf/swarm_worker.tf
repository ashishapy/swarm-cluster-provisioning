resource "aws_instance" "swarm-worker" {
  count         = "${var.swarm_workers}"
  ami           = "${var.swarm_ami_id}"
  instance_type = "${var.swarm_instance_type}"
  subnet_id     = "${aws_subnet.swarm-priv-subnet.id}"

  tags {
    Name = "swarm-worker-${count.index}"
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
      "docker swarm join --token ${var.swarm_worker_token} --advertise-addr ${self.private_ip} ${var.swarm_manager_ip}:2377",
    ]
  }
}
