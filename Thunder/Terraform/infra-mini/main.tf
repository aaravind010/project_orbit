resource "aws_vpc" "thunder_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "Thunder_Public_Subnet" {
  for_each          = var.Public_Subnet_CIDR
  vpc_id            = aws_vpc.thunder_vpc.id
  cidr_block        = each.value[0]
  availability_zone = each.key
  tags = {
    Name = var.Public_Subnet_names[each.key][0]
  }
}

resource "aws_subnet" "Thunder_Private_Subnet" {
  for_each          = var.Private_Subnet_CIDR
  vpc_id            = aws_vpc.thunder_vpc.id
  cidr_block        = each.value[0]
  availability_zone = each.key
  tags = {
    Name = var.Private_Subnet_Names[each.key][0]
  }
}

resource "aws_internet_gateway" "thunder_idw" {
  vpc_id = aws_vpc.thunder_vpc.id
  tags = {
    Name = var.Inetnet_Gateway_Name
  }
}

resource "aws_route_table" "Public_Route_Table" {
  vpc_id = aws_vpc.thunder_vpc.id
  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.thunder_idw.id
  }
  tags = {
    Name = var.Private_Route_Table_Name
  }
}

resource "aws_route_table_association" "Public_Route_Table_association" {
  for_each       = aws_subnet.Thunder_Public_Subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.Public_Route_Table.id
}

resource "aws_route_table" "Private_Route_Table" {
  vpc_id = aws_vpc.thunder_vpc.id
  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }
  tags = {
    Name = var.Private_Route_Table_Name
  }
}

resource "aws_route_table_association" "Private_Route_Table_association" {
  for_each       = aws_subnet.Thunder_Private_Subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.Private_Route_Table.id
}

resource "aws_key_pair" "orbit_key" {
  public_key = file("../keys/orbit_terra.pub")
}

resource "aws_security_group" "orbit_server_sg" {
  vpc_id = aws_vpc.thunder_vpc.id
  tags = {
    Name = "orbit_server_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "SSH_Rule" {
  security_group_id = aws_security_group.orbit_server_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "HHTPS_Rule" {
  security_group_id = aws_security_group.orbit_server_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}


resource "aws_vpc_security_group_ingress_rule" "HTTP_Rule" {
  security_group_id = aws_security_group.orbit_server_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "Outbound_rule" {
  security_group_id = aws_security_group.orbit_server_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = -1
  to_port           = -1
  ip_protocol       = "all"
}

resource "aws_instance" "orbit_server" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.orbit_key.key_name
  associate_public_ip_address = "true"
  subnet_id                   = aws_subnet.Thunder_Public_Subnet["us-east-1a"].id
  ebs_block_device {
    delete_on_termination = "true"
    device_name           = "/dev/xvda"
    volume_size           = 10
    volume_type           = "gp3"
  }
}
