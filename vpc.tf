data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = var.tags
}

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  availability_zone_id    = data.aws_availability_zones.available.zone_ids[0]
  cidr_block              = var.public_a_cidr_block
  map_public_ip_on_launch = true
  tags                    = merge({ "network" = "public" }, var.tags)
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  availability_zone_id    = data.aws_availability_zones.available.zone_ids[1]
  cidr_block              = var.public_b_cidr_block
  map_public_ip_on_launch = true
  tags                    = merge({ "network" = "public" }, var.tags)
}

resource "aws_subnet" "public_c" {
  vpc_id                  = aws_vpc.main.id
  availability_zone_id    = data.aws_availability_zones.available.zone_ids[2]
  cidr_block              = var.public_c_cidr_block
  map_public_ip_on_launch = true
  tags                    = merge({ "network" = "public" }, var.tags)
}

resource "aws_subnet" "private_a" {
  vpc_id               = aws_vpc.main.id
  availability_zone_id = data.aws_availability_zones.available.zone_ids[0]
  cidr_block           = var.private_a_cidr_block
  tags                 = merge({ "network" = "private" }, var.tags)
}

resource "aws_subnet" "private_b" {
  vpc_id               = aws_vpc.main.id
  availability_zone_id = data.aws_availability_zones.available.zone_ids[1]
  cidr_block           = var.private_b_cidr_block
  tags                 = merge({ "network" = "private" }, var.tags)
}

resource "aws_subnet" "private_c" {
  vpc_id               = aws_vpc.main.id
  availability_zone_id = data.aws_availability_zones.available.zone_ids[2]
  cidr_block           = var.private_c_cidr_block
  tags                 = merge({ "network" = "private" }, var.tags)
}

###############################
# Secondary CIDR For EKS Pods #
###############################
resource "aws_vpc_ipv4_cidr_block_association" "pod_cidr" {
  count      = var.pod_cidr_enabled ? 1 : 0
  vpc_id     = aws_vpc.main.id
  cidr_block = var.pod_cidr_block
  tags       = merge({ "network" = "internal" }, var.tags)
}

resource "aws_subnet" "pod_a" {
  count                = var.pod_cidr_enabled ? 1 : 0
  vpc_id               = aws_vpc_ipv4_cidr_block_association.pod_cidr.vpc_id
  availability_zone_id = data.aws_availability_zones.available.zone_ids[0]
  cidr_block           = var.pod_a_cidr_block
  tags                 = merge({ "network" = "pod" }, var.tags)
}

resource "aws_subnet" "pod_b" {
  count                = var.pod_cidr_enabled ? 1 : 0
  vpc_id               = aws_vpc_ipv4_cidr_block_association.pod_cidr.vpc_id
  availability_zone_id = data.aws_availability_zones.available.zone_ids[0]
  cidr_block           = var.pod_b_cidr_block
  tags                 = merge({ "network" = "pod" }, var.tags)
}

resource "aws_subnet" "pod_c" {
  count                = var.pod_cidr_enabled ? 1 : 0
  vpc_id               = aws_vpc_ipv4_cidr_block_association.pod_cidr.vpc_id
  availability_zone_id = data.aws_availability_zones.available.zone_ids[0]
  cidr_block           = var.pod_c_cidr_block
  tags                 = merge({ "network" = "pod" }, var.tags)
}