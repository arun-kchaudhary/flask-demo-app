# Define the AWS provider
provider "aws" {
  region = "ap-south-1"
}

# Create an ECR Repository
resource "aws_ecr_repository" "flask_app" {
  name = "flask-demo-app"
}

# Create a VPC
resource "aws_vpc" "flask_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create a subnet in ap-south-1a
resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.flask_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
}

# Create a subnet in ap-south-1b
resource "aws_subnet" "subnet_b" {
  vpc_id            = aws_vpc.flask_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1b"
}

# Create an IAM Role for EKS
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

# Attach EKS Cluster Policy to the Role
resource "aws_iam_role_policy_attachment" "flask_eks_policy" {
  role       = aws_iam_role.flask_eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# Create an EKS Cluster
resource "aws_eks_cluster" "flask_eks" {
  name     = "flask-eks-cluster"
  role_arn = aws_iam_role.flask_eks_role.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.subnet_a.id,
      aws_subnet.subnet_b.id
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.flask_eks_policy
  ]
}
