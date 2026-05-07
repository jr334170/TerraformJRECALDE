provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

terraform {
  backend "s3" {
    bucket       = "terraform-state-jr334170"
    key          = "practico/terraform.tfstate"
    region       = "us-east-1"
    profile      = "ort"
    use_lockfile = true
  }
}
