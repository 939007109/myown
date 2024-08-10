resource "aws_iam_role" "ecs_task_execution_role" {
    name = "${var.environment}-ecsTaskExecutionRole"

    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Action = "sts:AssumeRole",
                Effect = "Allow",
                Principal = {
                    Service = "ecs-tasks.amazonaws.com"
                }
            }
        ]
    })
    managed_policy_arns = [
        "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
    ]
    tags = {
        Name = "${var.environment}-ecsTaskExecutionRole"
        Environment = var.environment
    }
}

resource "aws_iam_role" "codebuild_role" {
  name = "codebuild-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
        Effect  = "Allow",
        Principal = {
            Service = "codebuild.amazonaws.com"
        }
        Action = "sts:AssumeRole"
    }]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess",
    "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess",
  ]
}

resource "aws_iam_role_policy" "coudbuild_policy" {
  name = "codebuild-policy"
  role = aws_iam_role.codebuild_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Effect = "Allow"
            Action = [
                "s3:GetObject",
                "s3:PutObject",
                "s3:ListBucket"
            ],
            Resource = [
                "arn:aws:s3:::${var.codebuild_bucket}",
                "arn:aws:s3:::${var.codebuild_bucket}/*"
            ]
        },
        {
            Effect = "Allow"
            Action =  [
                "logs:CreateLogGroup",
                "logs:CreateLogsStream",
                "logs:PutLogEvents"
            ]
            Resource = "*"
        }
    ]
  })
}


resource "aws_iam_role" "codepipeline_role" {
  name = "codepipeline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
        {
            Effect = "Allow",
            Principal = {
                Service = "codepipeline.amazonaws.com"
            },
            Action = "sts:AssumeRole"
        }
    ]
  })
}