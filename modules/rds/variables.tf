variable "name" {
  description = "Name tag for the RDS instance."
  type        = string
}

variable "allocated_storage" {
  description = "The allocated storage for the RDS instance."
  type        = number
}

variable "engine" {
  description = "The database engine to use."
  type        = string
}

variable "instance_class" {
  description = "The instance class for the RDS instance."
  type        = string
}

variable "username" {
  description = "The username for the RDS instance."
  type        = string
}

variable "password" {
  description = "The password for the RDS instance."
  type        = string
  sensitive   = true
}

variable "engine_version" {
  description = "The engine version for the RDS instance."
  type        = string
}

variable "parameter_group_name" {
  description = "The parameter group for the RDS instance."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the RDS instance."
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for the RDS instance."
  type        = list(string)
}

variable "publicly_accessible" {
  description = "Whether the RDS instance is publicly accessible."
  type        = bool
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot when deleting the RDS instance."
  type        = bool
}

