provider "aws" {
 alias = "useast1"
 region = "us-east-1"
}
provider "aws" {
 alias = "uswest1"
 region = "us-west-1"
}
variable "ami_value" {
description = "value of ami "
}
variable "instance_type_value" {
description = "value of instance "
}
variable "subnet_id_value"{
description = " value of subnet"
}
variable "bucket_value"{
description = "name of bucket "
}
module "aws_s3_bucket" {
  source = "./terraform_modules/s3_bucket"

  bucket_value = var.bucket_value

  providers = {
    aws = aws.uswest1
  }
}

module "aws_ec2_instance" {
  source = "./terraform_modules/ec2_instance"

  ami_value           = var.ami_value
  instance_type_value = var.instance_type_value
  subnet_id_value     = var.subnet_id_value

  providers = {
    aws = aws.useast1
  }
}
 



