resource "aws_subnet" "private_subnet_1a" {
    vpc_id = aws_vpc.eks_vpc.id
    cidr_block = "10.0.32.0/20"

    availability_zone = format("%sa", var.aws_region)

    tags = {
        "kubernetes.io/cluster/${var.vpc_name}" = "shared"
    }
}

resource "aws_subnet" "private_subnet_1b" {
    vpc_id = aws_vpc.eks_vpc.id
    cidr_block = "10.0.48.0/20"

    availability_zone = format("%sb", var.aws_region)

    tags = {
        "kubernetes.io/cluster/${var.vpc_name}" = "shared"
    }
}

resource "aws_route_table_association" "privsub1a" {
  subnet_id = aws_subnet.private_subnet_1a.id
  route_table_id = aws_route_table.natgtw.id
}

resource "aws_route_table_association" "privsub1b" {
  subnet_id = aws_subnet.private_subnet_1b.id
  route_table_id = aws_route_table.natgtw.id
}