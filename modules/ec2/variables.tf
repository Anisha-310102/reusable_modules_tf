variable "ami" {
  description = "The AMI ID to use for the instance."
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start."
  type        = string
}

variable "subnet_id" {
  description = "The VPC subnet ID to launch the instance in."
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the instance."
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to the instance."
  type        = map(string)
}

variable "environment" {
  description = "The environment in which the instance is deployed."
  type        = string
}

