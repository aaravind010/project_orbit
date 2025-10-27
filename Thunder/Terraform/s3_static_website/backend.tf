terraform {
  backend "s3" {
    bucket = "orbit-terraform-state0"
    key    = "s3_static_website/terraform.tfstate"
    region = "us-east-1"
  }
}