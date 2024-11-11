output "vpc_id" {
  value       = aws_vpc.ada_vpc.id
  description = "Id da VPC criada para teste da ADA"
}

output "bucket" {
  value       = aws_s3_bucket.s3_bucket.bucket
  description = "S3 Bucket"
}