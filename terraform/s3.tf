resource "aws_s3_bucket" "example" {
  bucket = "bucket1-ada"

  tags = {
    Name        = "bucket1-ada"
    Environment = "Dev"
  }
}