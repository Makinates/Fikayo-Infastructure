terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    profile = "fikayo"
    region = "us-east-1"
    key = "terraform.tfstate"
    bucket = "my-example-s3-bucket-2024"
  }
}
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

module "Vpc" {
  source = "./modules/vpc"
}