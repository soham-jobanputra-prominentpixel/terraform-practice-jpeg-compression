terraform {
  required_version = "~>1.14.7"

  backend "s3" {
    profile      = "TerraformBackend"
    use_lockfile = true
    region       = "us-east-1"
    bucket       = "terraform-backend-501046919017-us-east-1-an"
    key          = "terraform.tfstate"
  }

  required_providers {
    aws = {
      version = "~>6.38.0"
      source  = "hashicorp/aws"
    }
  }
}
