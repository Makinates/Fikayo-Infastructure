resource "aws_instance" "Vm" {
  ami = "ami-0bb84b8ffd87024d8"
  instance_type = "t3.medium"
  key_name = "Fikayo-keyPair1"
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF
  network_interface {
    network_interface_id = aws_network_interface.ENI.id
    device_index = 0
  }
  tags = {
    Name = "My_ec2"
  }
}

resource "aws_network_interface" "ENI" {
  subnet_id = aws_subnet.Public_subnet.id
  private_ip = var.ENI_IP
  security_groups = [aws_security_group.Faks_Sg.id]
    tags = {
      Name = var.ENI_Name
    }
}

resource "aws_eip" "Elastic_ip" {
  domain = "vpc"
}


resource "aws_eip_association" "eip_assoc" {
    allocation_id = aws_eip.Elastic_ip.id
  network_interface_id = aws_network_interface.ENI.id
}