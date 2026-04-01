terraform {
backend "s3" {
bucket = "terraform-kumar-infra"
key = "terraform_dev/terraform.tfstate"
region = "us-west-1"
dynamodb_table = "terraform-locks"
}
}

