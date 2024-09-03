provider "aws" {
  region = "ap-south-1"
}

resource "aws_ecr_repository" "flask_app" {
  name = "flask-demo-app"
}

resource "aws_vpc" "flask_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "flask_subnet" {
  vpc_id     = aws_vpc.flask_vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_eks_cluster" "flask_eks" {
  name     = "flask-eks-cluster"
  role_arn = aws_iam_role.flask_eks_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.flask_subnet.id]
  }
}

resource "aws_iam_role" "flask_eks_role" {
  name = "flask-eks-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}

