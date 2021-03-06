resource "aws_subnet" "public" {
  vpc_id                  = "${var.vpc_id}"
  availability_zone       = "${var.aws_az}"
  map_public_ip_on_launch = true

  cidr_block = "${var.public_cidr_block}"

  tags {
    Name              = "Kubernetes ${var.cluster_name} Public Subnet"
    KubernetesCluster = "${var.cluster_name}"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = "${var.vpc_id}"
  availability_zone = "${var.aws_az}"

  cidr_block = "${var.private_cidr_block}"

  tags {
    Name              = "Kubernetes ${var.cluster_name} Private Subnet"
    KubernetesCluster = "${var.cluster_name}"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = "${aws_subnet.private.id}"
  route_table_id = "${aws_route_table.private.id}"
}
