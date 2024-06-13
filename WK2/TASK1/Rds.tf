resource "aws_db_instance" "myRds" {
  allocated_storage    = 20
  db_name = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "mypassword"
  parameter_group_name = "default.mysql8.0"
  publicly_accessible  = true
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.main.name

  tags = {
    Name = "my-mysql-db"
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "main-db-subnet-group"
  subnet_ids = [aws_subnet.Public_subnet.id,aws_subnet.public2.id]

  tags = {
    Name = "main-db-subnet-group"
  }
}