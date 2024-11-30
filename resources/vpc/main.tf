provider "aws" {
  region = "us-west-1"  
}

module "vpc" {
  source       = "../../module/vpc"
  vpc_cidr     = "10.0.0.0/16"
  project_name = "my-project"
}
