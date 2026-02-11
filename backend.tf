terraform {
  backend "s3" {
    bucket = "PASTE_YOUR_BUCKET_NAME_HERE"
    key    = "github-actions-wordpress/terraform.tfstate"
    region = "us-east-1"
  }
}
