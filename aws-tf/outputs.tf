output "swarm_cluster_VPC_id" {
  value = "${aws_vpc.swarm-vpc.id}"
}

output "swarm_cluster_elb_dns" {
  value = "${aws_elb.swarm-cluster-elb.public_dns}"
}

output "swarm_manager_1_public_ip" {
  value = "${aws_instance.swarm-manager.0.public_ip}"
}

output "swarm_manager_2_public_ip" {
  value = "${aws_instance.swarm-manager.1.public_ip}"
}

output "swarm_manager_3_public_ip" {
  value = "${aws_instance.swarm-manager.2.public_ip}"
}
