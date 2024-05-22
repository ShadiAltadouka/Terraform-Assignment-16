resource "aws_s3_bucket" "bucket-1" {
  bucket = var.s3

}

resource "aws_s3_bucket_server_side_encryption_configuration" "kms-key" {
  bucket = aws_s3_bucket.bucket-1.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.kms
    }
  }

}