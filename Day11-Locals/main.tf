locals {
  environment   = "dev"
  instance_type = "t2.micro"
  name_prefix   = "${local.environment}-app"
}

resource "aws_instance" "example" {
  ami           = "ami-123456"
  instance_type = local.instance_type
  tags = {
    Name = local.name_prefix
  }
}
