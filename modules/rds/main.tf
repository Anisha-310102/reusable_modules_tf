resource "aws_db_subnet_group" "main" {
  name       = "${var.name}-rds-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "main" {
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  instance_class         = var.instance_class
  username               = var.username
  password               = var.password
  engine_version         = var.engine_version
  parameter_group_name   = var.parameter_group_name
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = var.security_group_ids
  publicly_accessible    = var.publicly_accessible
  skip_final_snapshot    = var.skip_final_snapshot
}



