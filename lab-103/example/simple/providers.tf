
terraform {
  required_version = ">= 1.2.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 4.4.0"
    }
  }

  backend "s3" {
    bucket         = "symple-terraform-repo"
    dynamodb_table = "symple-terraform-lock"
    key            = "symple-dev/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = false
    acl            = "bucket-owner-full-control"
  }
}
