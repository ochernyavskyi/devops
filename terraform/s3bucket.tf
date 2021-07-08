resource "aws_s3_bucket" "bucket" {
  bucket = "my-bucket-andersen-dev"
  acl = "private"
  tags = {
    Name = "My bucket"
  }
}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.bucket.id
  key = "index.html"
  acl = "public-read"
  source = "myfiles/index.html"
}