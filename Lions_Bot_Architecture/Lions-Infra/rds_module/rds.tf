
resource "aws_db_instance" "default1" {
  identifier             = var.identifier1
  allocated_storage    = var.storage1
  engine                = var.engine1
  engine_version        = var.engine_version1
  instance_class        = var.instance_class1
  db_name              = var.db_name1
  username               = var.username1
  password            = var.password1
  vpc_security_group_ids = [aws_security_group.sg-all1.id]
}

