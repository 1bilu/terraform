resource "aws_s3_bucket" "bucky" {
    bucket = "bilalkhan-9649"
    tags = {
      "Name" = "backend-bucket"
      "ENV"  = "backend"
    }
}

terraform {
  backend "s3" {
    bucket = "bilalkhan-9649"
    key    = "./bilu.tfstate"
    region = "eu-west-3"
  }
}