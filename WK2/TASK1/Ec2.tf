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