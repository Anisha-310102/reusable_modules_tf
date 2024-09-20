provider "aws" {
  region = "ap-southeast-2"  # Sydney region
}

# VPC Module
module "vpc" {
  source            = "./modules/vpc"
  name              = "my-vpc"
  cidr_block        = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  public_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets   = ["10.0.3.0/24", "10.0.4.0/24"]
  tags              = {
    Name = "my-vpc"
  }
}

# Load Balancer Module
module "load_balancer" {
  source              = "./modules/load_balancer"
  name                = "my-alb"
  security_groups     = [module.vpc.security_group_id]
  subnets             = module.vpc.public_subnets
  port                = 80
  protocol            = "HTTP"
  listener_port       = 80
  listener_protocol   = "HTTP"
  vpc_id              = module.vpc.vpc_id
}

# RDS Module
module "rds" {
  source                = "./modules/rds"
  name                  = "my-rds"
  allocated_storage     = 20
  engine                = "mysql"
  instance_class        = "db.t3.micro"
  username              = "admin"
  password              = "password"
  engine_version        = "8.0.35"
  parameter_group_name  = "default.mysql8.0"
  subnet_ids            = module.vpc.private_subnets
  security_group_ids    = [module.vpc.security_group_id]
  publicly_accessible   = false
  skip_final_snapshot   = true
}

# Auto Scaling Group Module
module "asg" {
  source                = "./modules/asg"
  name                  = "my-asg"
  ami_id                = "ami-0892a9c01908fafd1"
  instance_type         = "t2.micro"
  user_data             = "#!/bin/bash\necho Hello World > /var/www/html/index.html"
  min_size              = 1
  max_size              = 3
  desired_capacity      = 2
  subnet_ids            = module.vpc.public_subnets
  health_check_type     = "EC2"
  health_check_grace_period = 300
  force_delete          = false
  scale_up_adjustment   = 1
  scale_down_adjustment = -1
  scale_up_cooldown     = 300
  scale_down_cooldown   = 300
}


