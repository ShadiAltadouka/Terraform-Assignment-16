terraform {
  backend "s3" {
    bucket  = "shadi-tf-module-bucket"
    key     = "tf-state-file/terraform.tfstate"
    region  = "us-east-1"
    profile = "shadi"
    dynamodb_table = "dynamo-db-1"
    
  }

}