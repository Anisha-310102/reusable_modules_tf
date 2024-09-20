variable "name" {
  description = "Name tag for the ALB."
  type        = string
}

variable "security_groups" {
  description = "List of security group IDs for the ALB."
  type        = list(string)
}

variable "subnets" {
  description = "List of subnet IDs for the ALB."
  type        = list(string)
}

variable "port" {
  description = "Port for the target group."
  type        = number
}

variable "protocol" {
  description = "Protocol for the target group."
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the ALB is created."
  type        = string
}

variable "listener_port" {
  description = "Port for the ALB listener."
  type        = number
}

variable "listener_protocol" {
  description = "Protocol for the ALB listener."
  type        = string
}

