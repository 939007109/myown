resource "aws_network_acl" "public_nacl" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.vpc_name}-public-nacl"
    Environment = var.environment
  }
}

resource "aws_network_acl_rule" "public_http_ingress" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number = 100
  egress = false
  protocol = "all"
  cidr_block = "0.0.0.0/0"
  rule_action = "allow"
}


resource "aws_network_acl_rule" "public_nacl_egress" {
    network_acl_id =  aws_network_acl.public_nacl.id
    rule_number = 100
    egress = true
    protocol = "all"
    cidr_block = "0.0.0.0/0"
    rule_action = "allow"
}

resource "aws_network_acl_association" "public_nacl_associaiton" {
    count = length(var.public_subnets)
    subnet_id = var.public_subnets[count.index]
    network_acl_id = aws_network_acl.public_nacl.id
}

resource "aws_network_acl" "private_nacl" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.vpc_name}-private-nacl"
    Environment = var.environment
  }
}

resource "aws_network_acl_rule" "allow_all_outbound_private" {
  network_acl_id = aws_network_acl.private_nacl.id
  egress = true
  protocol = "all"
  rule_number = 100
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "allow_all_inbound_private" {
  network_acl_id = aws_network_acl.private_nacl.id
  egress = false
  protocol = "tcp"
  rule_number = 200
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
  from_port = 80
  to_port = 443
}

resource "aws_network_acl_association" "private_nacl_association" {
  count = length(var.private_subnets)
  subnet_id = var.private_subnets[count.index]
  network_acl_id = aws_network_acl.private_nacl.id
}