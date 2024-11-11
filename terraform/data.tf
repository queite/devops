data "aws_caller_identity" "current_aws_account" {

}

data "aws_region" "current_region" {

}

data "aws_instances" "running_instances" {
  instance_state_names = ["running"]
}

data "aws_caller_identity" "current" {
}

locals {
  tags_queite = "queite"
  s3_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowCloudFrontServicePrincipal",
        Effect = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action   = "s3:GetObject",
        Resource = "arn:aws:s3:::${aws_s3_bucket.s3_bucket.bucket}/*",
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.id}:distribution/${aws_cloudfront_distribution.s3_distribution.arn}"
          }
        }
      },
    ]
  })
}
