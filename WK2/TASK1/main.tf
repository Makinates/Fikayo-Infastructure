terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {}
}

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

resource "aws_subnet" "Public_subnet" {
  vpc_id = aws_vpc.faks_vpc.id
  availability_zone = "us-east-1b"
  cidr_block = "10.0.0.0/28"
  tags = {
    Name = "Public_subnet"
  }
}

resource "aws_route_table_association" "Public_subnet_association" {
  subnet_id = aws_subnet.Public_subnet.id
  route_table_id = aws_route_table.public_route.id  
}

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
resource "aws_instance" "Vm" {
  ami = "ami-0e001c9271cf7f3b9"
  instance_type = "t3.medium"
  key_name = "FikayoPair"
  # user_data = <<-EOF
  #             #!/bin/bash
  #             yum update -y
  #             yum install -y httpd
  #             systemctl start httpd
  #             systemctl enable httpd
  #             wget https://github.com/prometheus/prometheus/releases/download/v2.52.0/prometheus-2.52.0.linux-amd64.tar.gz
  #             tar xvfv prometheus*.tar.gz
  #             sudo mv prometheus-2.52.0.linux-amd64 /opt/prometheus
  #             EOF
  network_interface {
    network_interface_id = aws_network_interface.ENI.id
    device_index = 0
  }
  #  provisioner "remote-exec" {
  #   inline = [
  #     "sudo yum update -y",
  #     "sudo yum install -y git",
  #     "sudo yum install dotnet-sdk-6.0",  # Install .NET SDK
  #     "git clone https://github.com/fikay/360Rides.git",
  #     "cd 360Rides",
  #     "dotnet restore",  # Restore dependencies
  #     "dotnet publish -c Release -o published",  # Publish the application
  #     "sudo cp -r published /var/www/360Rides",  # Copy published files to web server directory
  #     "sudo systemctl restart nginx"  # Restart web server (assuming you're using Nginx)
  #   ]
  # }
  tags = {
    Name = "My_ec2"
  }
}

resource "aws_network_interface" "ENI" {
  subnet_id = aws_subnet.Public_subnet.id
  private_ip = aws_eip.Elastic_ip.public_ip
  security_groups = [aws_security_group.Faks_Sg.id]
    tags = {
      Name = "Public_ec2_eni"
    }
}

resource "aws_eip" "Elastic_ip" {
  domain = "vpc"
}

resource "aws_eip_association" "eip_assoc" {
    allocation_id = aws_eip.Elastic_ip.id
  network_interface_id = aws_network_interface.ENI.id
}