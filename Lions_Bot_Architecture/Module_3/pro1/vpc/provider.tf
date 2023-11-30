terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.23.1"
    }
  }
}

#provider settings can be used inside variables

 #provider kubernetes

#### providers ####
## accepter 
provider "aws" {
  region = "eu-west-1"
}


