terraform {
  required_version = "~> 1.14.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.39.0"
    }
  }

  backend "s3" {
    profile      = "TerraformBackend"
    use_lockfile = true
    region       = "us-east-1"
    bucket       = "terraform-backend-501046919017-us-east-1-an"
    key          = "jpeg-compression/terraform.tfstate"
  }
}
