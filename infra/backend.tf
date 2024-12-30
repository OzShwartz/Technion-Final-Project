terraform {
  backend "s3" {
    bucket         = "final-project-technion-24688"
    key            = "terraform/state/dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
