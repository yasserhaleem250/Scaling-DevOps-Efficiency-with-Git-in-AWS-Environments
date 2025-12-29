terraform {
  required_version = ">= 1.2"
  required_providers {
    aws = { source = "hashicorp/aws" }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "artifacts" {
  bucket = var.artifact_bucket_name
  acl    = "private"
}

resource "aws_codecommit_repository" "repo" {
  repository_name = var.codecommit_repo_name
  description     = "Source repository for Congdon & Coleman deployment"
}

resource "aws_codebuild_project" "project" {
  name          = "congdon-codebuild"
  service_role  = var.codebuild_service_role_arn

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:7.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = false
  }

  source {
    type = "CODECOMMIT"
    location = aws_codecommit_repository.repo.clone_url_http
    buildspec = file("buildspec.yml")
  }

  artifacts {
    type     = "S3"
    location = aws_s3_bucket.artifacts.bucket
    packaging = "ZIP"
  }
}

resource "aws_codepipeline" "pipeline" {
  name     = "congdon-pipeline"
  role_arn = var.codepipeline_role_arn

  artifact_store {
    location = aws_s3_bucket.artifacts.bucket
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        RepositoryName = aws_codecommit_repository.repo.repository_name
        BranchName     = var.code_branch
      }
    }
  }

  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      configuration = {
        ProjectName = aws_codebuild_project.project.name
      }
    }
  }

  # Add additional stages (Deploy) as needed (CodeDeploy, ECS, etc.)
}

resource "aws_codedeploy_app" "app" {
  name = "congdon-codedeploy-app"
  compute_platform = "Server"
}

resource "aws_codedeploy_deployment_group" "dg" {
  app_name               = aws_codedeploy_app.app.name
  deployment_group_name  = "congdon-deployment-group"
  service_role_arn       = var.codedeploy_service_role_arn

  # Placeholder for target configuration (EC2 tags, AutoScalingGroups, or ECS service)
}
