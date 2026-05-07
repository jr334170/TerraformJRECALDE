resource "aws_db_subnet_group" "main" {
  name       = "${var.name}-db-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = { Name = "${var.name}-db-subnet-group" }
}

resource "aws_security_group" "rds" {
  name   = "${var.name}-rds-sg"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "rds_ingress_from_app" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds.id
  source_security_group_id = var.app_security_group_id
}

resource "aws_db_instance" "main" {
  identifier             = "${var.name}-db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.instance_class
  allocated_storage      = 20
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false
  skip_final_snapshot    = true
  multi_az               = false
  tags                   = { Name = "${var.name}-db" }
}
