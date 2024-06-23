## fetch AMI ID ##
data "aws_ami" "ami_id" {
  most_recent = true
  filter {
    name   = "tag:Name"
    values = ["Golden-Image_2024-06-13"]
  }
}

## Fetch SG and Keypair ##
data "aws_key_pair" "keypair" {
  key_name           = "keypair3705"
  include_public_key = true
}

data "aws_security_group" "sg" {
  filter {
    name   = "tag:Name"
    values = ["management-sg"]
  }
}

## Fetch IAM role ##
data "aws_iam_role" "instance_role" {
  name = "CustomEC2AdminAccess"
}

## Fetch networking details ##
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["custom-vpc"]
  }
}

data "aws_subnet" "subnet" {
  filter {
    name   = "tag:Name"
    values = ["management-subnet"]
  }
}