resource "aws_subnet" "public_subnet_1a" {
  vpc_id = aws_vpc.eks_vpc.id

  cidr_block                = "10.0.0.0/20"
  map_public_ip_on_launch   = true
  availability_zone     = format("%sa", var.aws_region)

  tags = {
      "kubernetes.io/cluster/${var.vpc_name}" = "shared"
  }
}

resource "aws_subnet" "public_subnet_1b" {
  vpc_id = aws_vpc.eks_vpc.id

  cidr_block                = "10.0.16.0/20"
  map_public_ip_on_launch   = true
  availability_zone     = format("%sb", var.aws_region)

  tags = {
      "kubernetes.io/cluster/${var.vpc_name}" = "shared"
  }
}

resource "aws_route_table_association" "pubsub1a" {
  subnet_id = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.igw_route_table.id
}

resource "aws_route_table_association" "pubsub1b" {
  subnet_id = aws_subnet.public_subnet_1b.id
  route_table_id = aws_route_table.igw_route_table.id
}