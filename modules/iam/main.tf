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

    inline_policy {
      name = "${var.environment}-ecs-logs-policy"

      policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Effect = "Allow",
                Action = [
                    "logs:CreateLogGroup",
                    "logs:CreateLogStream",
                    "logs:PutLogEvents"
                ],
                Resource = "*"
            }
        ]
      })
    }

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
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess",
    "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
    "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
  ]
}

resource "aws_iam_role_policy" "coudbuild_policy" {
  name = "codebuild-policy"
  role = aws_iam_role.codebuild_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Effect = "Allow",
            Action = [
                "elasticloadbalancing:DescribeTags",
                "elasticloadbalancing:DescribeLoadBalancerAttributes",
                "elasticloadbalancing:DescribeTargetGroupAttributes",
                "dynamodb:GetItem",
                "dynamodb:PutItem",
                "dynamodb:DeleteItem",
                "secretsmanager:CreateSecret",
                "secretsmanager:DescribeSecret",
                "secretsmanager:GetResourcePolicy",
                "ecs:DescribeClusters",
                "ecs:DescribeServices",
                "ecs:DescribeTaskDefinition",
                "ecs:DescribeTasks",
                "iam:ListRolePolicies",
                "iam:GetRole",
                "iam:PassRole",
                "route53:GetHostedZone",
            ],
            Resource = "*"
        },
        {
            Effect = "Allow"
            Action = [
                "s3:GetObject",
                "s3:PutObject",
                "s3:ListBucket"
            ],
            Resource = [
                "arn:aws:s3:::${var.codebuild_bucket_id}",
                "arn:aws:s3:::${var.codebuild_bucket_id}/*"
            ]
        },
        {
            Effect = "Allow"
            Action =  [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
            Resource = "*"
        },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_admin_access" {
  role = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
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

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonECS_FullAccess",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
    "arn:aws:iam::aws:policy/IAMFullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess",
    "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
  ]
}

resource "aws_iam_role_policy" "codepipeline_policy" {
    name = "codepipeline-policy"
    role = aws_iam_role.codepipeline_role.id

    policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Effect = "Allow",
                Action = [
                    "s3:GetObject",
                    "s3:PutObject",
                    "s3:ListBucket"
                ],
                Resource = [
                    "arn:aws:s3:::${var.codebuild_bucket_id}",
                    "arn:aws:s3:::${var.codebuild_bucket_id}/*"
                ]
            },
            {
                Effect = "Allow",
                Action = [
                    "codebuild:BatchGetBuilds",
                    "codebuild:StartBuild"
                ],
                Resource = "*"
            },
            {
                Effect = "Allow",
                Action = [
                    "ec2:Describe*",
                    "elasticloadbalancing:Describe*",
                    "autoscaling:Describe*",
                    "cloudwatch:Describe*",
                    "cloudformation:Describe*",
                    "cloudformation:GetTemplate",
                    "cloudformation:ValidateTemplate"
                ],
                Resource = "*"
            }
        ]
    })
}

data "aws_caller_identity" "default" {}

resource "aws_s3_bucket_policy" "codepipeline_access" {
  bucket = var.codebuild_bucket_id

  policy = jsonencode(
    {
        "Version" = "2012-10-17",
        "Statement" = [
            {
                Effect = "Allow",
                Principal = {
                    AWS = "arn:aws:iam::${data.aws_caller_identity.default.account_id}:role/codepipeline-role"
                },
                Action = "s3:*",
                Resource = [
                    "arn:aws:s3:::${var.codebuild_bucket_id}",
                    "arn:aws:s3:::${var.codebuild_bucket_id}/*"
                ]
            }
        ]
    }
  )
}
