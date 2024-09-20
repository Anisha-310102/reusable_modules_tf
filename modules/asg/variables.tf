variable "name" {
  description = "Name of the ASG"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the launch configuration"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "user_data" {
  description = "User data to initialize the instance"
  type        = string
  default     = ""
}

variable "min_size" {
  description = "Minimum number of instances in the ASG"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances in the ASG"
  type        = number
}

variable "desired_capacity" {
  description = "Desired number of instances in the ASG"
  type        = number
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ASG"
  type        = list(string)
}

variable "health_check_type" {
  description = "Type of health check for the ASG"
  type        = string
  default     = "EC2"
}

variable "health_check_grace_period" {
  description = "Grace period for health checks (in seconds)"
  type        = number
  default     = 300
}

variable "force_delete" {
  description = "Whether to force delete the ASG when it's destroyed"
  type        = bool
  default     = false
}

variable "scale_up_adjustment" {
  description = "Number of instances to scale up by"
  type        = number
}

variable "scale_down_adjustment" {
  description = "Number of instances to scale down by"
  type        = number
}

variable "scale_up_cooldown" {
  description = "Cooldown period (in seconds) for scaling up"
  type        = number
}

variable "scale_down_cooldown" {
  description = "Cooldown period (in seconds) for scaling down"
  type        = number
}
variable "key_name" {
  description = "The name of the key pair to use for the instances."
  type        = string
}

