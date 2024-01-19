terraform { 
  required_providers {
    aws = {         # terrform is telling to aws provider
      source = "hashicorp/aws"
      version = "5.31.0" # aws provider version
    }
  }
  backend "s3" {
    bucket = "allmyaws"
    key    = "foreach"
    region = "us-east-1"
    dynamodb_table = "allmyaws-locking"
  }
}

provider "aws" {
  region = "us-east-1"
  # Configuration options
}