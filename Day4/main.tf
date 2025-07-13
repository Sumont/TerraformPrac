resource "aws_instance" "name" {
    ami = var.ami_id
    instance_type = "t2.micro"
    tags = {
      Name = "Sample"
    }
  
}

resource "aws_s3_bucket" "xyz" {
  bucket = "sumantxyz"
  
}