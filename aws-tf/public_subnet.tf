/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "swarm-ig" {
  vpc_id = "${aws_vpc.swarm-vpc.id}"

  tags {
    Name = "swarm_cluster"
  }
}

/* Public subnet */
resource "aws_subnet" "swarm-pub-subnet" {
  vpc_id                  = "${aws_vpc.swarm-vpc.id}"
  cidr_block              = "${var.public_subnet_cidr}"
  availability_zone       = "${var.availability_zone}"
  map_public_ip_on_launch = true
  depends_on              = ["aws_internet_gateway.swarm-ig"]

  tags {
    Name = "swarm_cluster"
  }
}

/* Routing table for public subnet */
resource "aws_route_table" "swarm-rt" {
  vpc_id = "${aws_vpc.swarm-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.swarm-ig.id}"
  }

  tags {
    Name = "swarm_cluster"
  }
}

/* Associate the routing table to public subnet */
resource "aws_route_table_association" "swarm-rt-asocn" {
  subnet_id      = "${aws_subnet.swarm-pub-subnet.id}"
  route_table_id = "${aws_route_table.swarm-rt.id}"
}
