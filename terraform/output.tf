output "vpc_id" {
  value       = aws_vpc.ada_vpc.id
  description = "Id da VPC criada para teste da ADA"
}