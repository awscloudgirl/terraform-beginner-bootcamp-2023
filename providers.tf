terraform {
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "projects-awscloudgirl"

  #  workspaces {
  #    name = "terra-house-tech-wellness"
  #  }
  #}
  #cloud {
  #  organization = "terra-house-tech-wellness"
  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.16.2"
    }
  }
}

provider "aws" {
}
provider "random" {
  # Configuration options
}