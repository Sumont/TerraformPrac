resource "aws_instance" "name" {
    ami = "ami-08a6efd148b1f7504"
    instance_type = "t2.micro"
   
  
}



resource "aws_s3_bucket" "name" {
    bucket = "adcgdcswdwdwdwdwdjj"
  
}

# terraform plan --target=aws_instance.name
