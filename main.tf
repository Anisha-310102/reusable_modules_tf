provider "aws" {
  region = "ap-southeast-2"  
}

module "vpc" {
  source          = "./modules/vpc"  # Path to the VPC module
  #cidr_block      = "10.0.0.0/16"    # Input CIDR block
   public_subnet_count      = 2
   #public_subnet_cidrs      = ["10.0.1.0/24", "10.0.2.0/24"]  
   private_subnet_count     = 2
  # private_subnet_cidrs     = ["10.0.3.0/24", "10.0.4.0/24"]
   #availability_zones = data.aws_availability_zones.available.names
  tags = {
    Environment = "dev"
  }
}
module "ec2_instance" {
  source            = "./modules/ec2"
 
  instance_type      = "t2.micro"     # Replace with your instance type
  subnet_id          = aws_subnet.public[0].id
  ami                 = var.ami
  environment         = var.environment
  security_group_ids   = [aws_security_group.default.id]
  tags = {
    Name        = "anisha-ec2-instance"
    environment = "dev"  # Replace with your environment
  }
}

module "asg" {
  source              = "./modules/asg"  # Path to the ASG module
  name            = "${var.tags["Name"]}-asg"
  #ami                 = var.ami
  ami_id                = "ami-0892a9c01908fafd1"
  instance_type       = var.instance_type
  #security_group_ids   = [aws_security_group.default.id]
  subnet_ids          = var.subnet_ids
  min_size            = 1
  max_size            = 3
  desired_capacity    = 1
  scale_up_cooldown   = 300
  scale_down_cooldown = 300
  scale_up_adjustment   = 1
  scale_down_adjustment = -1
  key_name            = "RSA"
}
module "alb" {
  source              = "./modules/alb"
  name                = "anisha-alb"
  port                = 80
  protocol            = "HTTP"
  vpc_id              = aws_vpc.main.id
  security_groups     = [aws_security_group.alb.id]
  subnets             = aws_vpc.main.public_subnets
  listener_protocol   = "HTTP"
  listener_port       = 80
}
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
  

