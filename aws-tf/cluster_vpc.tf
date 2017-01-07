/* Define our vpc */
resource "aws_vpc" "swarm-vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "swarm_cluster"
  }
}

resource "aws_vpc_dhcp_options" "swarm-dhcp" {
  domain_name         = "us-west-2.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags {
    Name = "swarm_cluster"
  }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = "${aws_vpc.swarm-vpc.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.swarm-dhcp.id}"
}
