provider "aws" {
  region                   = "ap-northeast-1"             # Tokyo
  profile                  = "terraform-project-user" # IAM User
  shared_credentials_files = ["C:/Users/hesaw/.aws/credentials"]
}