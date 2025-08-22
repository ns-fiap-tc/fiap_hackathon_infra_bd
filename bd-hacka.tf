resource "aws_db_subnet_group" "hacka_db_subnet_group" {
  name       = "hacka_db_subnet_group"
  subnet_ids = [
    data.aws_subnet.hacka_private_subnet_1.id,
    data.aws_subnet.hacka_private_subnet_2.id
  ]

  tags = {
    Name = "Database Subnet Group"
  }
}

resource "aws_security_group" "hacka_db_sg" {
  name        = "hacka_db_sg"
  description = "Security group para o RDS"
  vpc_id      = data.aws_vpc.hacka_vpc.id

  # Regras de segurança (exemplo para permitir tráfego de dentro da VPC)
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]  # Permitir acesso de dentro da VPC
    from_port   = 5432  # A porta do PostgreSQL
    to_port     = 5432  # A porta do PostgreSQL
    protocol    = "tcp"
  }

   tags = {
     Name = "hacka_db_sg"
   }
}

# Database
resource "aws_db_instance" "hacka_database" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "16.6"
  instance_class       = "db.t3.micro"
  identifier           = var.db_hacka_identifier
  username             = var.db_hacka_username
  password             = var.db_hacka_password
  db_name              = var.db_hacka_name
  skip_final_snapshot  = true
  #multi_az          = false
  #publicly_accessible = true

  vpc_security_group_ids = [aws_security_group.hacka_db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.hacka_db_subnet_group.name

  tags = {
    Name = "hacka_database"
  }
}