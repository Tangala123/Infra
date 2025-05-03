resource "aws_ecr_repository" "cvist-ecr-repo" {
  name = var.ecr_repo_name
}

output "ecr_repo_uri" {
  value = aws_ecr_repository.cvist-ecr-repo.repository_url
}
