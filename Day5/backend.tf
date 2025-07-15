terraform {
  backend "s3" {
    bucket = "sumantsstatefilebucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}