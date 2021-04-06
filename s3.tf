
    provider "aws" {
  region = "ap-south-1"
    access_key = var.access_key
    secret_key = var.secret_key

}


terraform {
  backend "s3" {
    bucket = "mybucket101"
    key    = "new-key"
    region = "ap-south-1"
  }

}

  
  resource "aws_sqs_queue" "queue" {
    name = aws_sqs_queue.queue.s3  
    }

  output "QueueName" {
    value = aws_sqs_queue.queue.name
  }

  data "terraform_remote_state" "network" {
      backend = "s3"
      config {
          bucket = "mybucket101"
          key    = "new-key"
          region = "ap-south-1"
      }
  }

 
