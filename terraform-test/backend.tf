terraform {
  backend "s3" {
    bucket  = "s3-tf-bucket-1"
    key     = "tf-state-file/terraform.tfstate"
    region  = "us-east-1"
    profile = "shadi"

  }

}