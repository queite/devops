resource "aws_s3_bucket" "s3_bucket" {
  bucket = "bucket-ada${data.aws_caller_identity.current_aws_account.id}"

  tags = {
    Name        = "bucket-ada-${data.aws_caller_identity.current_aws_account.id}-${data.aws_region.current_region.name}"
    Environment = "Dev-${local.tags_queite}"
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_cloudfront" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = local.s3_policy
}

# resource "aws_s3_bucket_policy" "allow_access_from_elb" {
#   bucket = aws_s3_bucket.s3_bucket.id
#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect    = "Allow",
#       Principal = { Service = "elasticloadbalancing.amazonaws.com" },
#       Action    = "s3:ListBucket",
#       Resource  = "arn:aws:s3:::${aws_s3_bucket.s3_bucket.bucket}",
#       Condition = {
#         StringEquals = {
#           "AWS:SourceArn" = "arn:aws:elasticloadbalancing:${data.aws_region.current_region.name}:${data.aws_caller_identity.current_aws_account.id}:loadbalancer/app/test-lb-tf/*"
#         }
#       }
#       },
#       {
#         Effect    = "Allow",
#         Principal = { Service = "elasticloadbalancing.amazonaws.com" },
#         Action    = "s3:GetObject",
#         Resource  = "arn:aws:s3:::${aws_s3_bucket.s3_bucket.bucket}/*",
#         Condition = {
#           StringEquals = {
#             "AWS:SourceArn" = "arn:aws:elasticloadbalancing:${data.aws_region.current_region.name}:${data.aws_caller_identity.current_aws_account.id}:loadbalancer/app/test-lb-tf/*"
#           }
#         }
#     }]
#   })
# }