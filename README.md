# kong-terraform-aws
Kong API Portal Installation Using Terraform


*********************main.tf***********************************
provider "aws" {
  region = "me-south-1"
  access_key = " "
  secret_key = " "
  profile = "dev"
}

module "kong" {
  source = "github.com/aws-cloud-lab/kong-terraform-aws"

  vpc                   = "1-VPC-Kong-API-UAT"
  environment           = "dev"
  ec2_ami = {
    me-south-1 = "ami-01ae5f73b4a68b104"
  }
  ec2_instance_type = "t3.medium"
  db_instance_class = "db.t3.medium"
  ec2_key_name          = "kongUAT"
  ssl_cert_external     = "farhanakthar.com"
  ssl_cert_internal     = "farhanakthar.com"
  ssl_cert_admin        = "farhanakthar.com"
  ssl_cert_manager      = "farhanakthar.com"
  ssl_cert_portal       = "farhanakthar.com"
  
  public_subnets = "private"
  default_security_group = "sg4-cp-ec1"
  db_subnets = "default-vpc-033766c6b63d69bce"
  
  enable_ee = true
  ee_license = " "
  ee_bintray_auth = " "
  
  tags = {
     Owner = "tech_fur@outlook.com"
     Team = "DevOps"
  }
}


******************main.tf***************************************
