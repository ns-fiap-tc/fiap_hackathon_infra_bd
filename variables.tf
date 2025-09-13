# AWS provider configuration
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

# Database hacka configuration
variable "db_hacka_username" {
  description = "The username for the Mongodb instance"
  type        = string
  sensitive   = true
}

variable "db_hacka_password" {
  description = "The password for the Mongodb instance"
  type        = string
  sensitive   = true
}

variable "db_hacka_name" {
  description = "Database hacka name"
  type        = string
  default     = "hackadb"
}

variable "db_hacka_identifier" {
  description = "The identifier for the RDS instance"
  type        = string
  default     = "hacka-db"
}
