# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket         = "terraform-state-geniusee-devops-task"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
    key            = "./terraform.tfstate"
    region         = "eu-west-2"
  }
}
