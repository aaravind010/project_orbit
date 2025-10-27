terraform {
  backend "s3" {
    bucket = "orbit-terraform-state0"
    key    = "simple_application_deploy/terraform.tfstate"
    region = "us-east-1"
  }
}