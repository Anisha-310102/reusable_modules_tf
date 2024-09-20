variable "cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default  = {
         Terraform = "true"
         Environment = "dev"
}
}
variable "availability_zones" {
  description = "List of availability zones."
  type        = list(string)
  default = ["ap-southeast-2a", "ap-southeast-2b"]
}

variable "public_subnet_count" {
  description = "Number of public subnets."
  type        = number
  
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_count" {
  description = "Number of private subnets."
  type        = number
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets."
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]

}


