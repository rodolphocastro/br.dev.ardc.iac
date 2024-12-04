# this folder will use AWS provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
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
}
