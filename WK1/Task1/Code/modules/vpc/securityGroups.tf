resource "aws_security_group" "Faks_Sg" {
  name = "Faks_Sg"
  description =  "Security group  for faks vpc"
  vpc_id = aws_vpc.faks_vpc.id

  tags = {
    name = "Fikayo-SG"
    key ="Faks_Sg" 
  }
  
}


resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.Faks_Sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  ip_protocol = "tcp"
  to_port = 80
  
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.Faks_Sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 22
  ip_protocol = "tcp"
  to_port = 22
  
}

resource "aws_vpc_security_group_ingress_rule" "allow_Icmp" {
  security_group_id = aws_security_group.Faks_Sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = -1
  ip_protocol = "icmp"
  to_port = -1
  
}

resource "aws_vpc_security_group_egress_rule" "Send_http" {
  cidr_ipv4 = "0.0.0.0/0"
 // from_port = 80
  ip_protocol = "-1"
  //to_port = 80
  security_group_id = aws_security_group.Faks_Sg.id
  
}


resource "aws_security_group" "Faks_Sg_private" {
  name = "Faks_Sg_private"
  description =  "Security group  for faks vpc private"
  vpc_id = aws_vpc.faks_vpc.id

  tags = {
    name = "Fikayo-SG_private"
    key ="Faks_Sg_private" 
  }
  
  ingress  {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    protocol = "tcp"
    to_port = 22
  }

  ingress {
    cidr_blocks = ["52.200.92.54/32"]
    from_port = 80
    protocol = "tcp"
    to_port = 80
  }

  egress  {
    cidr_blocks = ["52.200.92.54/32"]
    protocol = "tcp"
    to_port = 0
    from_port = 0
  }
}