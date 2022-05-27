terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
}
provider "aws" {
  region = "us-east-1"
}

resource "aws_dynamodb_table" "Camera_table" {
  name           = "Camera_table.test"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "Make"

  # table attributes
  attribute {
    name = "Make"
    type = "S"
  }

  # ttl
  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  # global secondary index (GSI)
  global_secondary_index {
    name            = "Camera_GSI"
    hash_key        = "Make"
    write_capacity  = 10
    read_capacity   = 10
    projection_type = "ALL"
  }

  # tag
  tags = {
    env       = "dev"
    TerraForm = "true"
  }
}