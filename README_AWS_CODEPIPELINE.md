# AWS Code* CI/CD Quickstart

This file outlines how to use the provided Terraform scaffold and deployment templates to set up AWS CodeCommit, CodeBuild, CodePipeline, and CodeDeploy.

Prerequisites
- AWS credentials with permissions to create S3, CodeCommit, CodeBuild, CodePipeline, CodeDeploy, IAM roles
- Terraform >= 1.2

Steps

1. Prepare IAM roles: Create service roles for CodeBuild, CodePipeline and CodeDeploy. Provide their ARNs to Terraform variables `codebuild_service_role_arn`, `codepipeline_role_arn`, and `codedeploy_service_role_arn`.

2. Initialize and apply Terraform:

```bash
cd aws-devops-project/aws/terraform
terraform init
terraform apply -var="codebuild_service_role_arn=arn:aws:iam::123456789012:role/CodeBuildRole" \
                -var="codepipeline_role_arn=arn:aws:iam::123456789012:role/CodePipelineRole" \
                -var="codedeploy_service_role_arn=arn:aws:iam::123456789012:role/CodeDeployRole" \
                -auto-approve
```

3. Push code to CodeCommit or connect external GitHub repo. If using CodeCommit, clone the CodeCommit repo and push source. The pipeline uses the repo and branch specified in variables.

4. Build & Deploy: Pipeline will trigger builds in CodeBuild using `aws/buildspec.yml`, produce artifacts to S3 and proceed to deploy stage (CodeDeploy placeholder).

Notes & Next Steps
- Replace `appspec.yml` and `hooks` to match your server/ECS/EC2 deployment layout.
- For EKS/ECS deployments, adapt the pipeline to call `kubectl` or update ECS services using `aws ecs update-service`.
- Configure CloudWatch Events/Alarms to monitor pipeline failures and CodeBuild metrics.
