/* NAT/VPN server */
resource "aws_instance" "swarm-nat" {
  ami               = "${lookup(var.aws_docker_amis, var.aws_default_region)}"
  instance_type     = "t2.micro"
  subnet_id         = "${aws_subnet.swarm-pub-subnet.id}"
  security_groups   = ["${aws_security_group.swarm-cluster.id}"]
  key_name          = "${aws_key_pair.deployer_key.key_name}"
  source_dest_check = false

  tags = {
    Name = "swarm-cluster"
  }

  connection {
    user     = "ubuntu"
    key_file = "${var.private_key_path}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo iptables -t nat -A POSTROUTING -j MASQUERADE",
      "echo 1 | sudo tee /proc/sys/net/ipv4/conf/all/forwarding > /dev/null",

      /* Initialize open vpn data container */
      "sudo mkdir -p /etc/openvpn",

      "docker run --name ovpn-data -v /etc/openvpn busybox",

      /* Generate OpenVPN server config */
      "docker run --volumes-from ovpn-data --rm gosuri/openvpn ovpn_genconfig -p ${var.vpc_cidr} -u udp://${aws_instance.swarm-nat.public_ip}",
    ]
  }
}
