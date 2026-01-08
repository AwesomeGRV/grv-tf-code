locals {
  resource_name_prefix = var.namespace
}

resource "aws_network_acl" "public" {
  count  = var.create_public_acl ? 1 : 0
  vpc_id = var.vpc_id
  tags = merge(
    var.tags,
    {
      Name = "${local.resource_name_prefix}-public-nacl"
    }
  )
}

resource "aws_network_acl" "private" {
  count  = var.create_private_acl ? 1 : 0
  vpc_id = var.vpc_id
  tags = merge(
    var.tags,
    {
      Name = "${local.resource_name_prefix}-private-nacl"
    }
  )
}

# Public Network ACL Rules - Inbound
resource "aws_network_acl_rule" "public_inbound_http" {
  count          = var.create_public_acl ? 1 : 0
  network_acl_id = aws_network_acl.public[0].id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block    = "0.0.0.0/0"
  from_port     = 80
  to_port       = 80
}

resource "aws_network_acl_rule" "public_inbound_https" {
  count          = var.create_public_acl ? 1 : 0
  network_acl_id = aws_network_acl.public[0].id
  rule_number    = 110
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block    = "0.0.0.0/0"
  from_port     = 443
  to_port       = 443
}

resource "aws_network_acl_rule" "public_inbound_ssh" {
  count          = var.create_public_acl && var.allow_ssh ? 1 : 0
  network_acl_id = aws_network_acl.public[0].id
  rule_number    = 120
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block    = var.ssh_allowed_cidr
  from_port     = 22
  to_port       = 22
}

resource "aws_network_acl_rule" "public_inbound_ephemeral" {
  count          = var.create_public_acl ? 1 : 0
  network_acl_id = aws_network_acl.public[0].id
  rule_number    = 130
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block    = "0.0.0.0/0"
  from_port     = 1024
  to_port       = 65535
}

resource "aws_network_acl_rule" "public_inbound_established" {
  count          = var.create_public_acl ? 1 : 0
  network_acl_id = aws_network_acl.public[0].id
  rule_number    = 140
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block    = "0.0.0.0/0"
  from_port     = 0
  to_port       = 0
}

# Public Network ACL Rules - Outbound
resource "aws_network_acl_rule" "public_outbound_http" {
  count          = var.create_public_acl ? 1 : 0
  network_acl_id = aws_network_acl.public[0].id
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block    = "0.0.0.0/0"
  from_port     = 80
  to_port       = 80
}

resource "aws_network_acl_rule" "public_outbound_https" {
  count          = var.create_public_acl ? 1 : 0
  network_acl_id = aws_network_acl.public[0].id
  rule_number    = 110
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block    = "0.0.0.0/0"
  from_port     = 443
  to_port       = 443
}

resource "aws_network_acl_rule" "public_outbound_ephemeral" {
  count          = var.create_public_acl ? 1 : 0
  network_acl_id = aws_network_acl.public[0].id
  rule_number    = 120
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block    = "0.0.0.0/0"
  from_port     = 1024
  to_port       = 65535
}

resource "aws_network_acl_rule" "public_outbound_established" {
  count          = var.create_public_acl ? 1 : 0
  network_acl_id = aws_network_acl.public[0].id
  rule_number    = 130
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block    = "0.0.0.0/0"
  from_port     = 0
  to_port       = 0
}

# Private Network ACL Rules - Inbound
resource "aws_network_acl_rule" "private_inbound_http" {
  count          = var.create_private_acl ? 1 : 0
  network_acl_id = aws_network_acl.private[0].id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block    = var.vpc_cidr
  from_port     = 80
  to_port       = 80
}

resource "aws_network_acl_rule" "private_inbound_https" {
  count          = var.create_private_acl ? 1 : 0
  network_acl_id = aws_network_acl.private[0].id
  rule_number    = 110
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block    = var.vpc_cidr
  from_port     = 443
  to_port       = 443
}

resource "aws_network_acl_rule" "private_inbound_ephemeral" {
  count          = var.create_private_acl ? 1 : 0
  network_acl_id = aws_network_acl.private[0].id
  rule_number    = 120
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block    = "0.0.0.0/0"
  from_port     = 1024
  to_port       = 65535
}

# Private Network ACL Rules - Outbound
resource "aws_network_acl_rule" "private_outbound_all" {
  count          = var.create_private_acl ? 1 : 0
  network_acl_id = aws_network_acl.private[0].id
  rule_number    = 100
  egress         = true
  protocol       = "all"
  rule_action    = "allow"
  cidr_block    = "0.0.0.0/0"
  from_port     = 0
  to_port       = 0
}

# Associate Network ACLs with Subnets
resource "aws_network_acl_association" "public" {
  count          = var.create_public_acl ? length(var.public_subnet_ids) : 0
  network_acl_id = aws_network_acl.public[0].id
  subnet_id      = var.public_subnet_ids[count.index]
}

resource "aws_network_acl_association" "private" {
  count          = var.create_private_acl ? length(var.private_subnet_ids) : 0
  network_acl_id = aws_network_acl.private[0].id
  subnet_id      = var.private_subnet_ids[count.index]
}
