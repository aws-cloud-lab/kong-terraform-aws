# Terraform state will be stored in S3
terraform {
  backend "s3" {
    bucket = "terraform-statebucket-kong"
    key    = "terraform.tfstate"
    region = "me-south-1"
  }
}

provider "aws" {
  region = "me-south-1"
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
  #private_subnets = "private"
  default_security_group = "sg4-cp-ec1"
  db_subnets = "default-vpc-033766c6b63d69bce"

  enable_ee = true
  ee_license = "{\"license\":{\"version\":1,\"signature\":\"52865c9a344b77836282ffe261fb413f397a8026e86092ca07e628adf4bd5305b1a47ce56159419decf8b3d55cb306c5c3f76ce14e8ac965e551f48e7f5d7ac2\",\"payload\":{\"customer\":\"First Abu Dhabi Bank\",\"license_creation_date\":\"2020-6-2\",\"product_subscription\":\"Kong Enterprise Edition\",\"support_plan\":\"Platinum\",\"admin_seats\":\"5\",\"license_expiration_date\":\"2021-05-04\",\"license_key\":\"0011K000029btR9QAI_a1V1K000007POM0UAO\"}}}"
  ee_bintray_auth = "first-abu-dhabi-bank_ganapathy-elumalai@kong:4bba4f601f626041cc9402a8f176b93d59d8ce3c"

  tags = {
      Owner = "tech_fur@outlook.com"
      Team = "DevOps"
  }
}
