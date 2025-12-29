# Scaling DevOps Efficiency with Git in AWS Environments

This project contains Terraform and CI/CD templates to implement a Git-based CI/CD workflow on AWS using CodeCommit, CodeBuild, CodePipeline, and CodeDeploy.

What is included
- `main.tf`, `variables.tf` — Terraform scaffold to create S3 artifact bucket, CodeCommit repo, CodeBuild project, CodePipeline, and CodeDeploy placeholders.
- `buildspec.yml` — CodeBuild buildspec example.
- `appspec.yml` — CodeDeploy appspec placeholder.
- `GitFlow.md` — GitFlow branching strategy and commands.

Quickstart

1. Configure AWS credentials and create IAM roles (CodeBuild, CodePipeline, CodeDeploy). Provide ARNs to Terraform variables.

```bash
cd aws-devops-project
terraform init
terraform apply -var="codebuild_service_role_arn=arn:aws:iam::123456789012:role/CodeBuildRole" \
                -var="codepipeline_role_arn=arn:aws:iam::123456789012:role/CodePipelineRole" \
                -var="codedeploy_service_role_arn=arn:aws:iam::123456789012:role/CodeDeployRole" \
                -auto-approve
```

2. Push your application code to the created CodeCommit repository (or point pipeline to another repo).

3. Pipeline will run CodeBuild using `buildspec.yml` and store artifacts in S3.

Notes
- Replace placeholders and review IAM permissions before running in production.
- For EKS/ECS deployments, adapt pipeline stages to publish to ECR and update services.
