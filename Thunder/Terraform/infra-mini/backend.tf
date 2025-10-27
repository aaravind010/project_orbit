terraform {
  backend "s3" {
    bucket = "orbit-terraform-state0"
    key    = "infra-mini/terraform.tfstate"
    region = "us-east-1"
  }
}
