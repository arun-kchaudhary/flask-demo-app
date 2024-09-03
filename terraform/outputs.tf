output "ecr_repo_url" {
  value = aws_ecr_repository.flask_app[0].repository_url
}
output "eks_cluster_name" {
  value = aws_eks_cluster.flask_eks.name
}

