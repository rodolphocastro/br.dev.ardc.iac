# this folder will use AWS provider
terraform {
  # using AWS default provider for terraform
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.20"
    }

  }

  # backend for storing tfstate
  # this should be created manually the first time
  backend "s3" {
    bucket = "ardc-tf-bucket"
    key    = "tf"
    region = "us-east-2"
  }
}

# common values for elements under this file
locals {
  tags = {
    Environment = "Production"
    Area        = "Platform"
    Owner       = "ralves"
    CreatedBy   = "Terraform"
  }
}

# default the provider to us-east-2
provider "aws" {
  region = "us-east-2"
}

# create a budget for the account, monthly U$10
resource "aws_budgets_budget" "aws-budget" {
  name              = "ardc-aws-budget"
  budget_type       = "COST"
  limit_amount      = 10
  limit_unit        = "USD"
  time_period_end   = "2087-06-15_00:00"
  time_period_start = "2024-12-01_00:00"
  time_unit         = "MONTHLY"
  tags              = local.tags
}

resource "random_password" "psql-password" {
  length  = 18
  special = false
}

resource "aws_secretsmanager_secret" "psql-password-secret" {
  name        = "psql-password"
  description = "Password for the PSQL database"
  tags        = local.tags
}

resource "aws_secretsmanager_secret_version" "psql-password-value" {
  secret_id     = aws_secretsmanager_secret.psql-password-secret.id
  secret_string = random_password.psql-password.result
}

# resource "aws_db_instance" "ardc-psql" {
#   identifier              = "ardc-psql-instance"
#   engine                  = "postgres"
#   engine_version          = "16.3"
#   instance_class          = "db.t3.micro"
#   username                = "postgres"
#   password                = random_password.psql-password.result
#   publicly_accessible     = true
#   allocated_storage       = 20
#   storage_type            = "gp2"
#   backup_retention_period = 1
#   skip_final_snapshot     = true
#   storage_encrypted       = true
#   tags                    = local.tags
# }

resource "aws_secretsmanager_secret" "psql-connection-string-secret" {
  name        = "psql-connection-string"
  description = "Connection string for the PSQL database"
  tags        = local.tags
}

# resource "aws_secretsmanager_secret_version" "psql-connection-string-value" {
#   secret_id     = aws_secretsmanager_secret.psql-connection-string-secret.id
#   secret_string = "postgresql://${aws_db_instance.ardc-psql.username}:${random_password.psql-password.result}@${aws_db_instance.ardc-psql.endpoint}/${aws_db_instance.ardc-psql.db_name}"
# }

# AWS Resource Group for everything created by Terraform
resource "aws_resourcegroups_group" "platform-rg" {
  name = "platform-rg"
  tags = local.tags
  resource_query {
    query = <<JSON
  {
    "ResourceTypeFilters": ["AWS::AllSupported"],
    "TagFilters": [
    {
      "Key": "Area",
      "Values": ["Platform"]
    }
    ]
  }
  JSON
  }
}
