resource "aws_dynamodb_table" "dynamodb" {
    name = var.dynamodb-name
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
    
    attribute {
      name = "LockID"
      type = "S"
    }

}