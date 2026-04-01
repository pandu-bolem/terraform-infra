provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}
terraform {
required_providers {
aws = {
source = "hashicorp/aws"
}
}
}
resource "aws_instance" "kumar" {
 ami = var.ami_value
 instance_type = var.instance_type_value
 key_name = "terraform"
 subnet_id = var.subnet_id_value
 provider = aws.us-east-1
}


