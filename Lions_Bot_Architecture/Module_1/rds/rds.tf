

resource "aws_db_instance" "default" {
  
  identifier             = var.identifier
  allocated_storage      = var.storage
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  db_name                = var.db_name
  username               = var.username
  password               = var.password
  
}

