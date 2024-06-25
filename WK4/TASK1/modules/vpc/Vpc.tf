resource "aws_vpc" "faks_vpc" {
    cidr_block = "10.0.0.0/24"
}

resource "aws_internet_gateway" "Igw" {
  vpc_id = aws_vpc.faks_vpc.id

  tags = {
    Name = "Main_Igw"
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.faks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Igw.id
  }

  tags = {
    Name = "Public_Route_Table"
  }
  
}

resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.faks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.My_Nat.id
  }

  tags = {
    Name = "Private_Route_table"
  }
  
}

resource "aws_subnet" "Public_subnet" {
  vpc_id = aws_vpc.faks_vpc.id
  availability_zone = "us-east-1b"
  cidr_block = "10.0.0.0/28"
  tags = {
    Name = "Public_subnet"
  }
}

resource "aws_subnet" "Private_subnet" {
  vpc_id = aws_vpc.faks_vpc.id
  cidr_block = "10.0.0.16/28"
  tags = {
    Name = "Private_subnet"
  }
}

resource "aws_eip" "eip_Nat"{
  domain = "vpc"
  tags = {
    Name = "EIP_FOR_NAT"
  }
}

resource "aws_nat_gateway" "My_Nat" {
  connectivity_type = "public"
  allocation_id = aws_eip.eip_Nat.id
  subnet_id = aws_subnet.Public_subnet.id


  depends_on = [ aws_internet_gateway.Igw ]
  
  
}

# resource "aws_eip_association" "eip_and_nat" {
#    allocation_id = aws_eip.eip_Nat.id
#   network_interface_id = aws_nat_gateway.My_Nat.id
  
# }
resource "aws_route_table_association" "Public_subnet_association" {
  subnet_id = aws_subnet.Public_subnet.id
  route_table_id = aws_route_table.public_route.id
  
  
  
}

resource "aws_route_table_association" "Private_subnet_association" {
  subnet_id = aws_subnet.Private_subnet.id
  route_table_id = aws_route_table.private_route.id
  
}


# resource "aws_vpc_security_group_egress_rule" "outbound_http" {
#   cidr_ipv4 = "0.0.0.0/0"
#   to_port = 80
#   from_port = 80
#   ip_protocol = "tcp"
#   security_group_id = aws_security_group.Faks_Sg.id
  
# }
# resource "aws_vpc_security_group_egress_rule" "Send_ssh" {
#   cidr_ipv4 = "0.0.0.0/0"
#   from_port = 22
#   ip_protocol = "tcp"
#   to_port = 22
#   security_group_id = aws_security_group.Faks_Sg.id
  
# }


