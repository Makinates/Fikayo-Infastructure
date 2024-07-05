resource "aws_iam_role" "developers" {
  name               = "Developers"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action    = "sts:AssumeRole"
      }
    ]
  })
}



resource "aws_iam_policy" "vpc_policy" {
  name        = "VPCPolicy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Action    = [
          "ec2:CreateVpc",
          "ec2:DeleteVpc",
          "ec2:DescribeVpcs",
          "ec2:ModifyVpcAttribute",
          "ec2:Associate*",
          "ec2:Disassociate*",
          "ec2:CreateInternetGateway",
          "ec2:DeleteInternetGateway",
          "ec2:AttachInternetGateway",
          "ec2:DetachInternetGateway",
          "ec2:CreateSubnet",
          "ec2:DeleteSubnet",
          "ec2:DescribeSubnets",
          "ec2:ModifySubnetAttribute",
          "ec2:CreateRouteTable",
          "ec2:DeleteRouteTable",
          "ec2:DescribeRouteTables",
          "ec2:AssociateRouteTable",
          "ec2:DisassociateRouteTable",
          "ec2:CreateRoute",
          "ec2:DeleteRoute",
          "ec2:ReplaceRoute",
          "ec2:CreateNatGateway",
          "ec2:DeleteNatGateway",
          "ec2:DescribeNatGateways",
          "ec2:CreateEgressOnlyInternetGateway",
          "ec2:DeleteEgressOnlyInternetGateway",
          "ec2:DescribeEgressOnlyInternetGateways",
          "ec2:CreateSecurityGroup",
          "ec2:DeleteSecurityGroup",
          "ec2:DescribeSecurityGroups",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:AuthorizeSecurityGroupEgress",
          "ec2:RevokeSecurityGroupIngress",
          "ec2:RevokeSecurityGroupEgress",
          "ec2:CreateNetworkAcl",
          "ec2:DeleteNetworkAcl",
          "ec2:DescribeNetworkAcls",
          "ec2:CreateNetworkAclEntry",
          "ec2:DeleteNetworkAclEntry",
          "ec2:ReplaceNetworkAclEntry",
          "ec2:CreateNetworkInterface",
          "ec2:DeleteNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:AttachNetworkInterface",
          "ec2:DetachNetworkInterface",
          "ec2:AssignIpv6Addresses",
          "ec2:UnassignIpv6Addresses",
          "ec2:AssignPrivateIpAddresses",
          "ec2:UnassignPrivateIpAddresses",
          "ec2:DescribeAddresses",
          "ec2:AllocateAddress",
          "ec2:ReleaseAddress"
        ],
        Resource  = "*"
      }
    ]
  })
}


resource "aws_iam_role" "operations" {
  name = "Operations"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_vpc_policy" {
  role       = aws_iam_role.operations.name
  policy_arn = aws_iam_policy.vpc_policy.arn
}


resource "aws_iam_role" "secrets_management_role" {
  name               = "Developers"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_policy" "secrets_management_policy" {
  name = "secretsManagementPolicy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "secretsmanager:GetSecretValue",
        "Resource": [
          aws_secretsmanager_secret.my_database_secret.arn,
          aws_secretsmanager_secret.my_Api_secret.arn
        ]
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "attach_secrets_policy" {
  role       = aws_iam_role.secrets_management_role.name
  policy_arn = aws_iam_policy.secrets_management_policy.arn
}
