/* Private subnet */
resource "aws_subnet" "swarm-priv-subnet" {
  vpc_id                  = "${aws_vpc.swarm-vpc.id}"
  cidr_block              = "${var.private_subnet_cidr}"
  availability_zone       = "${var.availability_zone}"
  map_public_ip_on_launch = false
  depends_on              = ["aws_instance.swarm-nat"]

  tags {
    Name = "swarm_cluster"
  }
}

/* Routing table for private subnet */
resource "aws_route_table" "swarm-priv-rt" {
  vpc_id = "${aws_vpc.swarm-vpc.id}"

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = "${aws_instance.swarm-nat.id}"
  }
}

/* Associate the routing table to public subnet */
resource "aws_route_table_association" "swarm-priv-rt-asocn" {
  subnet_id      = "${aws_subnet.swarm-priv-subnet.id}"
  route_table_id = "${aws_route_table.swarm-priv-rt.id}"
}
