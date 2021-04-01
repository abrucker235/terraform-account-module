resource "aws_security_group" "endpoints" {
  name        = "VPC Endpoints"
  description = "Allow communication to endpoints"
  vpc_id      = aws_vpc.main.id
  tags        = var.tags

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.private_1a_cidr_block, var.private_1b_cidr_block, var.private_1c_cidr_block]
  }

  #Secondary ingress could be added if pod network should be able to directly talk vpc endpoints.

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc_endpoint" "logs" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.private_1a.id, aws_subnet.private_1b.id, aws_subnet.private_1c.id]
  security_group_ids  = [aws_security_group.endpoints.id]
  private_dns_enabled = true
  tags                = merge({ "Name" = "Cloudwatch" }, var.tags)
}

resource "aws_vpc_endpoint" "trail" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${var.region}.cloudtrail"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.private_1a.id, aws_subnet.private_1b.id, aws_subnet.private_1c.id]
  security_group_ids  = [aws_security_group.endpoints.id]
  private_dns_enabled = true
  tags                = merge({ "Name" = "Cloudtrail" }, var.tags)
}

resource "aws_vpc_endpoint" "ec2" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${var.region}.ec2"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.private_1a.id, aws_subnet.private_1b.id, aws_subnet.private_1c.id]
  security_group_ids  = [aws_security_group.endpoints.id]
  private_dns_enabled = true
  tags                = merge({ "Name" = "EC2" }, var.tags)
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.private_1a.id, aws_subnet.private_1b.id, aws_subnet.private_1c.id]
  security_group_ids  = [aws_security_group.endpoints.id]
  private_dns_enabled = true
  tags                = merge({ "Name" = "EC2 Messages" }, var.tags)
}