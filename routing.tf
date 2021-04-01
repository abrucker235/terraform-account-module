##########################
# Private Subnet Routing #
##########################

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags   = var.tags
}

resource "aws_route_table_association" "public_a" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_a.id
}

resource "aws_route_table_association" "public_b" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_b.id
}

resource "aws_route_table_association" "public_c" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.public_c.id
}

##########################
# Private Subnet Routing #
##########################

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags   = var.tags
}

resource "aws_route_table_association" "private_a" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private_a.id
}

resource "aws_route_table_association" "private_b" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private_b.id
}

resource "aws_route_table_association" "private_c" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private_c.id
}

######################
# Pod Subnet Routing #
######################

resource "aws_route_table" "pod" {
  count  = var.pod_cidr_enabled ? 1 : 0
  vpc_id = aws_vpc.main.id
  tags   = var.tags
}

resource "aws_route_table_association" "pod_a" {
  count          = var.pod_cidr_enabled ? 1 : 0
  route_table_id = aws_route_table_pod.id
  subnet_id      = aws_subnet.pod.a.id
}

resource "aws_route_table_association" "pod_b" {
  count          = var.pod_cidr_enabled ? 1 : 0
  route_table_id = aws_route_table.pod.id
  subnet_id      = aws_subnet.pod_b.id
}

resource "aws_route_table_association" "pod_c" {
  count          = var.pod_cidr_enabled ? 1 : 0
  route_table_id = aws_route_table.pod.id
  subnet_id      = aws_subnet.pod_c.id
}