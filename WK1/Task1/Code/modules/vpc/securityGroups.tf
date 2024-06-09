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

resource "aws_vpc_security_group_ingress_rule" "allow_Prometheus" {
  security_group_id = aws_security_group.Faks_Sg.id
  cidr_ipv4         = "0.0.0.0/0"  # Allow access from any IPv4 address. Adjust as needed.
  from_port         = 9090        # The port you want to allow access to (Prometheus default port)
  to_port           = 9090       # Same as from_port for a single port
  ip_protocol       = "tcp"        # Protocol to allow (TCP in this case)
}

resource "aws_vpc_security_group_ingress_rule" "allow_Prometheus_elastic" {
  security_group_id = aws_security_group.Faks_Sg.id
  cidr_ipv4         = "0.0.0.0/0"  # Allow access from any IPv4 address. Adjust as needed.
  from_port         = 9114        # The port you want to allow access to (Prometheus default port)
  to_port           = 9114       # Same as from_port for a single port
  ip_protocol       = "tcp"        # Protocol to allow (TCP in this case)
}

resource "aws_vpc_security_group_ingress_rule" "allow_Prometheus_Kibana" {
  security_group_id = aws_security_group.Faks_Sg.id
  cidr_ipv4         = "0.0.0.0/0"  # Allow access from any IPv4 address. Adjust as needed.
  from_port         = 5601        # The port you want to allow access to (Prometheus default port)
  to_port           = 5601       # Same as from_port for a single port
  ip_protocol       = "tcp"        # Protocol to allow (TCP in this case)
}

resource "aws_vpc_security_group_ingress_rule" "allow_Prometheus1" {
  security_group_id = aws_security_group.Faks_Sg.id
  cidr_ipv4         = "0.0.0.0/0"  # Allow access from any IPv4 address. Adjust as needed.
  from_port         = 9100       # The port you want to allow access to (Prometheus default port)
  to_port           = 9100       # Same as from_port for a single port
  ip_protocol       = "tcp"        # Protocol to allow (TCP in this case)
}
resource "aws_vpc_security_group_ingress_rule" "allow_Prometheus2" {
  security_group_id = aws_security_group.Faks_Sg.id
  cidr_ipv4         = "0.0.0.0/0"  # Allow access from any IPv4 address. Adjust as needed.
  from_port         = 9200       # The port you want to allow access to (Prometheus default port)
  to_port           = 9200       # Same as from_port for a single port
  ip_protocol       = "tcp"        # Protocol to allow (TCP in this case)
}

resource "aws_vpc_security_group_egress_rule" "allow_Prometheus_egress1" {
  security_group_id = aws_security_group.Faks_Sg.id
  cidr_ipv4         = "0.0.0.0/0"  # Allow outbound traffic to any IPv4 address. Adjust as needed.
  from_port         = 9100         # The port you want to allow outbound access to (Prometheus default port)
  to_port           = 9100        # Same as from_port for a single port
  ip_protocol       = "tcp"        # Protocol to allow (TCP in this case)
}

resource "aws_vpc_security_group_egress_rule" "allow_Prometheus_egress2" {
  security_group_id = aws_security_group.Faks_Sg.id
  cidr_ipv4         = "0.0.0.0/0"  # Allow outbound traffic to any IPv4 address. Adjust as needed.
  from_port         = 9200         # The port you want to allow outbound access to (Prometheus default port)
  to_port           = 9200        # Same as from_port for a single port
  ip_protocol       = "tcp"        # Protocol to allow (TCP in this case)
}

resource "aws_vpc_security_group_egress_rule" "allow_Prometheus_egress_elastic" {
  security_group_id = aws_security_group.Faks_Sg.id
  cidr_ipv4         = "0.0.0.0/0"  # Allow outbound traffic to any IPv4 address. Adjust as needed.
  from_port         = 9114         # The port you want to allow outbound access to (Prometheus default port)
  to_port           = 9114        # Same as from_port for a single port
  ip_protocol       = "tcp"        # Protocol to allow (TCP in this case)
}

resource "aws_vpc_security_group_egress_rule" "allow_Prometheus_egress_kibana" {
  security_group_id = aws_security_group.Faks_Sg.id
  cidr_ipv4         = "0.0.0.0/0"  # Allow outbound traffic to any IPv4 address. Adjust as needed.
  from_port         = 5601         # The port you want to allow outbound access to (Prometheus default port)
  to_port           = 5601        # Same as from_port for a single port
  ip_protocol       = "tcp"        # Protocol to allow (TCP in this case)
}

resource "aws_vpc_security_group_egress_rule" "allow_Prometheus_egress" {
  security_group_id = aws_security_group.Faks_Sg.id
  cidr_ipv4         = "0.0.0.0/0"  # Allow outbound traffic to any IPv4 address. Adjust as needed.
  from_port         = 9090         # The port you want to allow outbound access to (Prometheus default port)
  to_port           = 9090         # Same as from_port for a single port
  ip_protocol       = "tcp"        # Protocol to allow (TCP in this case)
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
    cidr_blocks = ["10.0.0.0/24"]
    from_port = 22
    protocol = "tcp"
    to_port = 22
  }

  ingress  {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 9100
    protocol = "tcp"
    to_port = 9100
  }
  ingress  {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 9090
    protocol = "tcp"
    to_port = 9090
  }

  ingress {
    cidr_blocks = ["10.0.0.0/24"]
    from_port = 80
    protocol = "tcp"
    to_port = 80
  }
  ingress {
    cidr_blocks = ["10.0.0.0/24"]
    from_port = -1
    protocol = "icmp"
    to_port = -1
  }

  egress  {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 9100
    protocol = "tcp"
    to_port = 9100
  }
  egress  {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 9090
    protocol = "tcp"
    to_port = 9090
  }

 egress  {
    cidr_blocks = ["10.0.0.0/24"]
    protocol = "tcp"
    to_port = 22
    from_port = 22
  }

  egress  {
    cidr_blocks = ["10.0.0.0/24"]
    protocol = "icmp"
    to_port = -1
    from_port = -1
  }

  egress  {
    cidr_blocks = ["0.0.0.0/0"]
    protocol = -1
    to_port = 0
    from_port = 0
  }
}