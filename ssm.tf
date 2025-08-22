resource "aws_ssm_parameter" "db_hacka_username" {
  name  = "/hacka/db_hacka_username"
  type  = "SecureString"
  value = var.db_hacka_username
}

resource "aws_ssm_parameter" "db_hacka_password" {
  name  = "/hacka/db_hacka_password"
  type  = "SecureString"
  value = var.db_hacka_password
}
