variable "ENI_Name" {
  default = "My-ENI"
  type = string
  
}

variable "ENI_IP" {
  default = "10.0.0.16"
}

# variable "use_to_allow_ip" {
#   default = aws_instance.Vm.public_ip + "/32"
# }