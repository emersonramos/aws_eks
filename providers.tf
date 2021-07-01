terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.47.0"
    }
  }
}

provider "aws" {
  region                  = "sa-east-1"
  shared_credentials_file = "c:/Users/%userprofile%/.aws/credentials"
}