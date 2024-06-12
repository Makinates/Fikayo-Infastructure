terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {}
}


resource "aws_ssm_parameter" "foo" {
  name = "foo"
  type = "String"
  value = "bar"
}