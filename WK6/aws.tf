provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "branch_office_vm" {
  ami           = "ami-0c55b159cbfafe1f0" # Update with your AMI
  instance_type = "t2.micro"
  tags = {
    Name = "BranchOfficeVM"
  }
}
