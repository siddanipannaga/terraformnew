terraform { 
  required_providers {
    aws = {         # terrform is telling to aws provider
      source = "hashicorp/aws"
      version = "5.31.0" # aws provider version
    }
  }
}

provider "aws" {
  region = "us-east-1"
  # Configuration options
}