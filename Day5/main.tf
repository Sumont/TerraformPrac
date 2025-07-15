resource "aws_instance" "name" {
    ami = "ami-0150ccaf51ab55a51"
    instance_type = "t2.micro"
    tags = {
      Name = "Sample"
    }
  
}

resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
  
}