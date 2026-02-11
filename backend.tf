terraform {
  backend "s3" {
    bucket = "anusha-tfstate-614"
    key    = "github-actions-wordpress/terraform.tfstate"
    region = "us-east-1"
  }
}
