terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.26.0"
    }
  }
}


provider "aws" {
  region = "ap-southeast-1" 
}