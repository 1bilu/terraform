provider "aws" {
    region = "eu-west-3"
  
}

resource "aws_s3_bucket" "my_bucky" {
    bucket = "my-09-bucketbilu"

    tags = {
      Name="bilu"
    }
  
}