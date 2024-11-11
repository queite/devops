terraform {
  required_version = ">=1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.74.0"
    }
  }
  backend "s3" { #salva o state do terraform no bucket (compartilhamento de state)
    bucket = "terraform-back-ada"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      dono    = "queite"
      projeto = "terraform-ada"
    }
  }
}