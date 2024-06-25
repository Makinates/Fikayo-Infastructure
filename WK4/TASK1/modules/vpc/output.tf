output "Public_ip" {
    description = "Public ip for the Ec2"
  value = aws_instance.Vm.public_ip 
}