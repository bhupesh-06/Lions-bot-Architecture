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
#requester
provider "aws" {
  region = "ap-southeast-1"
}



