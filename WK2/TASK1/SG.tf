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


resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.faks_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow from anywhere (not recommended for production)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}