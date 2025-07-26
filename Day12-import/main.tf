/*resource "aws_instance" "name" {


  }
*/

resource "aws_instance" "name" {
     ami="ami-08a6efd148b1f7504"
     instance_type="t2.micro"
     tags= {
        "Name": "myserver"
    }
}

#$ terraform import aws_instance.name i-0036cd14a94a5bdef