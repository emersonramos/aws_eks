terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.56.0"
    }
  }
}

provider "aws" {
  region                  = "us-east-1"
  # Windows
  shared_credentials_file = "c:/Users/%userprofile%/.aws/credentials"
  # Linux
  #shared_credentials_file = "~/.aws/credentials"
}