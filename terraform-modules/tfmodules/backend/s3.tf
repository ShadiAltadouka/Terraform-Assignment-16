resource "aws_s3_bucket" "bucket-2" {
  bucket = var.s3-bucket-2

}

resource "aws_s3_bucket_versioning" "name" {
  bucket = aws_s3_bucket.bucket-2.id

  versioning_configuration {
    status = var.version-status
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "rsa" {
  bucket = aws_s3_bucket.bucket-2.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.rsa
      kms_master_key_id = aws_kms_key.encrypt.id
    }
  }

  depends_on = [aws_kms_key.encrypt]

}

resource "aws_kms_key" "encrypt" {
    key_usage = "ENCRYPT_DECRYPT"
    description = "kms key for s3 bucket"
  
}