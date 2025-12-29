variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "artifact_bucket_name" {
  type    = string
  default = "congdon-artifacts-bucket-000"
}

variable "codecommit_repo_name" {
  type    = string
  default = "congdon-repo"
}

variable "code_branch" {
  type    = string
  default = "main"
}

variable "codebuild_service_role_arn" {
  type    = string
  default = ""
}

variable "codepipeline_role_arn" {
  type    = string
  default = ""
}

variable "codedeploy_service_role_arn" {
  type    = string
  default = ""
}
