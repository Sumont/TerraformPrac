resource "aws_vpc" "dev_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "dev"
  }
}

resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnet-1"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "subnet-2"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = [
    aws_subnet.subnet_1.id,
    aws_subnet.subnet_2.id
  ]

  tags = {
    Name = "My DB Subnet Group"
  }
}

resource "aws_security_group" "rds_sg" {
  name   = "rds-security-group"
  vpc_id = aws_vpc.dev_vpc.id

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

resource "aws_db_instance" "book_db" {
  allocated_storage       = 10
  identifier              = "book-rds"
  db_name                 = "mydb"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = "admin"
  password                = "YourSecurePassword123!" # 🔐 Secure this properly
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.id
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  parameter_group_name    = "default.mysql8.0"

  backup_retention_period = 7
  backup_window           = "02:00-03:00"
  maintenance_window      = "sun:04:00-sun:05:00"
  deletion_protection     = false
  skip_final_snapshot     = true

  depends_on = [aws_db_subnet_group.db_subnet_group]
}
