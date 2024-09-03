variable "region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "flask-eks-cluster"
}

variable "instance_type" {
  description = "The EC2 instance type for worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "desired_capacity" {
  description = "The number of worker nodes to maintain in the EKS cluster"
  type        = number
  default     = 2
}

variable "max_capacity" {
  description = "The maximum number of worker nodes in the EKS cluster"
  type        = number
  default     = 3
}

variable "min_capacity" {
  description = "The minimum number of worker nodes in the EKS cluster"
  type        = number
  default     = 1
}

