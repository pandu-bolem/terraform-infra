terraform {
required_providers {
 aws = {
 source = "hashicorp/aws"
}
}
}
resource "aws_s3_bucket" "alestagamah2341412" {
  bucket = var.bucket_value
}
