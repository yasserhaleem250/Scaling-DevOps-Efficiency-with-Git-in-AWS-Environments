# IAM role & policy helper (aws/iam)

This folder contains example IAM policy documents and trust policies for creating service roles for CodeBuild, CodePipeline, and CodeDeploy.

Create roles and attach inline policies (example commands):

```bash
# Create role with trust policy
aws iam create-role --role-name CodeBuildServiceRole --assume-role-policy-document file://aws/iam/codebuild-trust.json

# Attach inline policy
aws iam put-role-policy --role-name CodeBuildServiceRole --policy-name CodeBuildInlinePolicy --policy-document file://aws/iam/codebuild-policy.json

# Repeat for CodePipeline
aws iam create-role --role-name CodePipelineServiceRole --assume-role-policy-document file://aws/iam/codepipeline-trust.json
aws iam put-role-policy --role-name CodePipelineServiceRole --policy-name CodePipelineInlinePolicy --policy-document file://aws/iam/codepipeline-policy.json

# Repeat for CodeDeploy
aws iam create-role --role-name CodeDeployServiceRole --assume-role-policy-document file://aws/iam/codedeploy-trust.json
aws iam put-role-policy --role-name CodeDeployServiceRole --policy-name CodeDeployInlinePolicy --policy-document file://aws/iam/codedeploy-policy.json
```

Notes
- These policies are minimal examples and use Resource: "*" for simplicity — tighten to least privilege before production.
- After creating roles, provide their ARNs to the Terraform variables (or let Terraform create roles in `aws/terraform`).
- For EKS/ECR interactions, add the relevant ECR and IAM permissions to the CodeBuild policy.
# IAM role & policy helper (deploy/aws/iam)

This folder contains example IAM policy documents and trust policies for creating service roles for CodeBuild, CodePipeline, and CodeDeploy.

Create roles and attach inline policies (example commands):

```bash
# Create role with trust policy
aws iam create-role --role-name CodeBuildServiceRole --assume-role-policy-document file://deploy/aws/iam/codebuild-trust.json

# Attach inline policy
aws iam put-role-policy --role-name CodeBuildServiceRole --policy-name CodeBuildInlinePolicy --policy-document file://deploy/aws/iam/codebuild-policy.json

# Repeat for CodePipeline
aws iam create-role --role-name CodePipelineServiceRole --assume-role-policy-document file://deploy/aws/iam/codepipeline-trust.json
aws iam put-role-policy --role-name CodePipelineServiceRole --policy-name CodePipelineInlinePolicy --policy-document file://deploy/aws/iam/codepipeline-policy.json

# Repeat for CodeDeploy
aws iam create-role --role-name CodeDeployServiceRole --assume-role-policy-document file://deploy/aws/iam/codedeploy-trust.json
aws iam put-role-policy --role-name CodeDeployServiceRole --policy-name CodeDeployInlinePolicy --policy-document file://deploy/aws/iam/codedeploy-policy.json
```

Notes
- These policies are minimal examples and use Resource: "*" for simplicity — tighten to least privilege before production.
- After creating roles, provide their ARNs to the Terraform variables: `codebuild_service_role_arn`, `codepipeline_role_arn`, `codedeploy_service_role_arn`.
- For EKS/ECR interactions, add the relevant ECR and IAM permissions to the CodeBuild policy.
