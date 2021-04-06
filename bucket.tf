 provider "aws" {
    region = "ap-south-1"
    access_key = var.access_key
    secret_key = var.secret_key
 }

 terraform {
  backend "s3" {
    bucket = "misba-terraform-bucket"
    key    = "global/vpc/ap-south-1/example_state.tfstate"
    region = "ap-south-1"
    encrypt = "true"
   access_key = var.access_key
secret_key = var.secret_key
   
  }
}
  
resource "aws_s3_bucket" "bucket" {
 bucket = "misba-terraform-bucket"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "test"
  }

  versioning{
      enabled = "true"
  }
}

resource "aws_iam_role_policy" "test_policy" {
  name = "test_policy"
  role = aws_iam_role.test_role.id

  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "test_role" {
  name = "test_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}