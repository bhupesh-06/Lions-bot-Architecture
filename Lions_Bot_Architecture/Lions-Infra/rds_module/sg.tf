

resource "aws_security_group" "sg-all1" {
  name        = "main_rds_sg1"
  description = "Allow all inbound traffic"
  vpc_id  = var.vpc1_id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "for-all-inbound" 
  }
}