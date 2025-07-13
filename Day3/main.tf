resource "aws_instance" "name" {
    ami = var.ami_id
    instance_type = "t2.micro"
    tags = {
      Name = "Sample"
    }
  
}

resource "aws_instance" "name1" {
    ami = var.ami_id
    instance_type = "t2.micro"
    tags = {
      Name = "Example"
    }
  
}