# VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "dev-vpc"
  }
}

# Subnets (two different AZs)
resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "subnet_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"
}

# RDS Subnet Group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]

  tags = {
    Name = "RDS Subnet Group"
  }
}

# Create Secret in Secrets Manager
resource "aws_secretsmanager_secret" "rds_secret" {
  name = "mydb-credentials"
}

# Store actual credentials in the secret
resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id     = aws_secretsmanager_secret.rds_secret.id
  secret_string = jsonencode({
    username = "admin"
    password = "MySecurePassword123!"  # Replace with your desired strong password
  })
}


resource "aws_security_group" "rds_sg" {
  name   = "rds-security-group"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # ⚠️ Restrict this in production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}


# RDS Instance using Secrets Manager
resource "aws_db_instance" "rds_instance" {
  identifier              = "mydb-instance"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  db_name                 = "mydb"
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.id
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true
  deletion_protection     = false
  backup_retention_period = 7
  username                = jsondecode(aws_secretsmanager_secret_version.rds_secret_version.secret_string)["username"]
  password                = jsondecode(aws_secretsmanager_secret_version.rds_secret_version.secret_string)["password"]
  publicly_accessible     = false
  parameter_group_name    = "default.mysql8.0"
  maintenance_window      = "sun:04:00-sun:05:00"
  backup_window           = "02:00-03:00"

  depends_on = [
    aws_db_subnet_group.rds_subnet_group,
    aws_secretsmanager_secret_version.rds_secret_version
  ]
}
