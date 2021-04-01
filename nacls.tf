#######################
# Public Subnet NACLs #
#######################

resource "aws_network_acl" "public" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = [aws_subnet.public_a.id, aws_subnet.public_b.id, aws_subnet.public_c.id]
  tags       = var.tags
}

resource "aws_network_acl_rule" "internet_ingress" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  rule_action    = "allow"
  egress         = false
  protocol       = "tcp"
  from_port      = 443
  to_port        = 443
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "public_to_private_a" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  rule_action    = "allow"
  egress         = true
  protocol       = "tcp"
  from_port      = 443
  to_port        = 443
  cidr_block     = var.private_a_cidr_block
}

resource "aws_network_acl_rule" "public_to_private_b" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  rule_action    = "allow"
  egress         = true
  protocol       = "tcp"
  from_port      = 443
  to_port        = 443
  cidr_block     = var.private_b_cidr_block
}

resource "aws_network_acl_rule" "public_to_private_c" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  rule_action    = "allow"
  egress         = true
  protocol       = "tcp"
  from_port      = 443
  to_port        = 443
  cidr_block     = var.private_c_cidr_block
}


########################
# Private Subnet NACLs #
########################

resource "aws_network_acl" "private" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = [aws_subnet.private_a.id, aws_subnet.private_b.id, aws_subnet.private_c.id]
  tags       = var.tags
}

resource "aws_network_acl_rule" "public_a_ingress" {
  network_acl_id = aws_network_acl.private.id
  rule_number    = 100
  rule_action    = "allow"
  egress         = false
  protocol       = "tcp"
  from_port      = 443
  to_port        = 443
  cidr_block     = var.public_a_cidr_block
}

resource "aws_network_acl_rule" "public_b_ingress" {
  network_acl_id = aws_network_acl.private.id
  rule_number    = 110
  rule_action    = "allow"
  egress         = false
  protocol       = "tcp"
  from_port      = 443
  to_port        = 443
  cidr_block     = var.public_b_cidr_block
}

resource "aws_network_acl_rule" "public_c_ingress" {
  network_acl_id = aws_network_acl.private.id
  rule_number    = 120
  rule_action    = "allow"
  egress         = false
  protocol       = "tcp"
  from_port      = 443
  to_port        = 443
  cidr_block     = var.public_c_cidr_block
}

resource "aws_network_acl_rule" "private_a_ingress" {
  network_acl_id = aws_network_acl.private.id
  rule_number    = 200
  rule_action    = "allow"
  egress         = false
  protocol       = "-1"
  from_port      = 0
  to_port        = 0
  cidr_block     = var.private_a_cidr_block
}

resource "aws_network_acl_rule" "private_b_ingress" {
  network_acl_id = aws_network_acl.private.id
  rule_number    = 210
  rule_action    = "allow"
  egress         = false
  protocol       = "-1"
  from_port      = 0
  to_port        = 0
  cidr_block     = var.private_b_cidr_block
}

resource "aws_network_acl_rule" "private_c_ingress" {
  network_acl_id = aws_network_acl.private.id
  rule_number    = 220
  rule_action    = "allow"
  egress         = false
  protocol       = "-1"
  from_port      = 0
  to_port        = 0
  cidr_block     = var.private_c_cidr_block
}

resource "aws_network_acl_rule" "private_a_egress" {
  network_acl_id = aws_network_acl.private.id
  rule_number    = 200
  rule_action    = "allow"
  egress         = true
  protocol       = "-1"
  from_port      = 0
  to_port        = 0
  cidr_block     = var.private_a_cidr_block
}

resource "aws_network_acl_rule" "private_b_egress" {
  network_acl_id = aws_network_acl.private.id
  rule_number    = 210
  rule_action    = "allow"
  egress         = true
  protocol       = "-1"
  from_port      = 0
  to_port        = 0
  cidr_block     = var.private_b_cidr_block
}

resource "aws_network_acl_rule" "private_c_egress" {
  network_acl_id = aws_network_acl.private.id
  rule_number    = 220
  rule_action    = "allow"
  egress         = true
  protocol       = "-1"
  from_port      = 0
  to_port        = 0
  cidr_block     = var.private_c_cidr_block
}

# Pod rules have the ability to be changed depending up CNI used.
resource "aws_network_acl_rule" "pod_a_ingress" {
  count          = var.pod_cidr_enabled ? 1 : 0
  network_acl_id = aws_network_acl.private.id
  rule_number    = 300
  rule_action    = "allow"
  egress         = false
  protocol       = "-1"
  from_port      = 0
  to_port        = 0
  cidr_block     = var.pod_a_cidr_block
}

resource "aws_network_acl_rule" "pod_b_ingress" {
  count          = var.pod_cidr_enabled ? 1 : 0
  network_acl_id = aws_network_acl.private.id
  rule_number    = 310
  rule_action    = "allow"
  egress         = false
  protocol       = "-0"
  from_port      = 0
  to_port        = 0
  cidr_block     = var.pod_b_cidr_block
}

resource "aws_network_acl_rule" "pod_c_ingress" {
  count          = var.pod_cidr_enabled ? 1 : 0
  network_acl_id = aws_network_acl.private.id
  rule_number    = 320
  rule_action    = "allow"
  egress         = false
  protocol       = "-1"
  from_port      = 0
  to_port        = 0
  cidr_block     = var.pod_c_cidr_block
}

resource "aws_network_acl_rule" "pod_a_egress" {
  count          = var.pod_cidr_enabled ? 1 : 0
  network_acl_id = aws_network_acl.private.id
  rule_number    = 300
  rule_action    = "allow"
  egress         = true
  protocol       = "-1"
  from_port      = 0
  to_port        = 0
  cidr_block     = var.pod_a_cidr_block
}

resource "aws_network_acl_rule" "pod_b_egress" {
  count          = var.pod_cidr_enabled ? 1 : 0
  network_acl_id = aws_network_acl.private.id
  rule_number    = 310
  rule_action    = "allow"
  egress         = true
  protocol       = "-0"
  from_port      = 0
  to_port        = 0
  cidr_block     = var.pod_b_cidr_block
}

resource "aws_network_acl_rule" "pod_c_egress" {
  count          = var.pod_cidr_enabled ? 1 : 0
  network_acl_id = aws_network_acl.private.id
  rule_number    = 320
  rule_action    = "allow"
  egress         = true
  protocol       = "-1"
  from_port      = 0
  to_port        = 0
  cidr_block     = var.pod_c_cidr_block
}

####################
# Pod Subnet NACLs #
####################

resource "aws_network_acl" "pod" {
  count      = var.pod_cidr_enabled ? 1 : 0
  vpc_id     = aws_vpc.main.id
  subnet_ids = [aws_subnet.pod_a.id, aws_subnet.pod_b.id, aws_subnet.pod_c.id]
  tags       = var.tags
}

resource "aws_network_acl_rule" "private_a_pod_ingress" {
  count          = var.pod_cidr_enabled ? 1 : 0
  network_acl_id = aws_network_acl.pod.id
  rule_number    = 200
  rule_action    = "allow"
  egress         = false
  protocol       = "-1"
  from_port      = 0
  to_port        = 0
  cidr_block     = var.private_a_cidr_block
}

resource "aws_network_acl_rule" "private_b_pod_ingress" {
  count          = var.pod_cidr_enabled ? 1 : 0
  network_acl_id = aws_network_acl.pod.id
  rule_number    = 210
  rule_action    = "allow"
  egress         = false
  protocol       = "-1"
  from_port      = 0
  to_port        = 0
  cidr_block     = var.private_b_cidr_block
}

resource "aws_network_acl_rule" "private_c_pod_ingress" {
  count          = var.pod_cidr_enabled ? 1 : 0
  network_acl_id = aws_network_acl.pod.id
  rule_number    = 220
  rule_action    = "allow"
  egress         = false
  protocol       = "-1"
  from_port      = 0
  to_port        = 0
  cidr_block     = var.private_c_cidr_block
}

resource "aws_network_acl_rule" "private_a_pod_egress" {
  count          = var.pod_cidr_enabled ? 1 : 0
  network_acl_id = aws_network_acl.pod.id
  rule_number    = 200
  rule_action    = "allow"
  egress         = true
  protocol       = "-1"
  from_port      = 0
  to_port        = 0
  cidr_block     = var.private_a_cidr_block
}

resource "aws_network_acl_rule" "private_b_pod_egress" {
  count          = var.pod_cidr_enabled ? 1 : 0
  network_acl_id = aws_network_acl.pod.id
  rule_number    = 210
  rule_action    = "allow"
  egress         = true
  protocol       = "-1"
  from_port      = 0
  to_port        = 0
  cidr_block     = var.private_b_cidr_block
}

resource "aws_network_acl_rule" "private_c_pod_egress" {
  count          = var.pod_cidr_enabled ? 1 : 0
  network_acl_id = aws_network_acl.pod.id
  rule_number    = 220
  rule_action    = "allow"
  egress         = true
  protocol       = "-1"
  from_port      = 0
  to_port        = 0
  cidr_block     = var.private_c_cidr_block
}