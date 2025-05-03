resource "aws_ecr_repository" "selected" {
  name = var.ecr_repo_name
}

output "ecr_repo_uri" {
  value = aws_ecr_repository.selected.repository_url
}
