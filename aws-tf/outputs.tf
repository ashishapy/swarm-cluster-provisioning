output "swarm_cluster_VPC_id" {
  value = "${aws_vpc.swarm-vpc.id}"
}

output "NAT_public_ip" {
  value = "${aws_instance.swarm-nat.public_ip}"
}

output "swarm_cluster_elb_dns" {
  value = "${aws_elb.swarm-cluster-elb.public_dns}"
}

output "swarm_manager_1_private_ip" {
  value = "${aws_instance.swarm-manager.0.private_ip}"
}

output "swarm_manager_2_private_ip" {
  value = "${aws_instance.swarm-manager.1.private_ip}"
}

output "swarm_manager_3_private_ip" {
  value = "${aws_instance.swarm-manager.2.private_ip}"
}
