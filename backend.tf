# Terraform Backend Configuration
# Uncomment and configure the backend for production use

# S3 Backend Example
# terraform {
#   backend "s3" {
#     bucket         = "your-terraform-state-bucket"
#     key            = "multi-vpc-infrastructure/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "terraform-locks"
#   }
# }

# Local Backend (for development only)
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
