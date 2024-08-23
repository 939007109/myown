# Project_9ACTS Infrastructure Setup

## Overview

This project repository contains the Terraform code and build specifications required to set up and manage infrastructure for the Project-9ACTS. The project is structured to support different environments, primarily `dev`, with global configurations applicable across all environments.

## Prerequisites
- Terraform 1.3.0 or higher
- AWS CLI configured with appropriate permissions
- Docker (for building images)
- GitHub Token (for CI/CD pipeline)

## Setup
1. **Clone the repository**:
git clone https://github.com/DKBIT1792/project-9acts.git
cd project-9acts

2. **Initialize Terraform**:
cd global/
terraform init

3. **Review and apply Terraform configurations**:
terraform plan
terraform apply -var "github_token=your_github_token_value"

*Note*: This process is same for directories 'global/' and 'environment/dev'

4. **Set up the CI/CD pipelines**:
Apply the Terraform configurations in cicd.tf to set up the CodePipeline and CodeBuild

5. **Deploy the Application**:
Once the CI/CD pipeline is setup, push the application code to the configured repository, and the pipeline will automatically deploy it.

## Environments
**Global**:
The 'global' directory contains Terraform configurations that are shared across all environments. This may include resources like S3 buckets and other that need to be consistent across environments.

**Dev**:
The 'dev' directory contains Terraform configurations specific to the development environment. This includes resources like VPC, IAM roles, S3 buckets, ECR, ECS cluster setup.

**Modules**:
The 'modules' directory contains reusable Terraform modules that can be used across different environments.

## Build Specifications
**buildspec_app.yml**:
Defines the build and deployment process for the application in the 'app' environment, includes building docker images and pushing them to Amazon ECR

**buildspec_dev.yml**:
Defines the build and deployment process for the development environment.

**buildspec_global.yml**:
Defines the build and deployment process for the global resources that are common across environments.

## Managing State
Terraform state is managed remotely using an S# bucket and DynamoDB for state locking and consistency. Ensure that the backend configuration is correctly set up in "backend.tf".

## License
This project is licensed under the MIT License.
