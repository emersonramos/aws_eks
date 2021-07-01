resource "aws_eip" "vpc_iep" {
    vpc = true
}

resource "aws_nat_gateway" "natgtw" {
    allocation_id   = aws_eip.vpc_iep.id
    subnet_id       = aws_subnet.public_subnet_1a.id

}

resource "aws_route_table" "natgtw" {
    vpc_id = aws_vpc.eks_vpc.id

}

resource "aws_route" "nat_route" {
    route_table_id = aws_route_table.natgtw.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgtw.id
}