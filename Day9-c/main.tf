module "dev" {
    source = "github.com/Sumont/TerraformPrac/Day9-a"
    ami_id = "ami-0150ccaf51ab55a51"
    instance_type = "t2.micro"
}
