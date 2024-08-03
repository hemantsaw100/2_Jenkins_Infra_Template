terraform {
  backend "s3" {
    bucket = "jenkins-infra-template"
    key    = "2_Jenkins_Infra_Template\terraform.tfstate"
    region = "ap-northeast-1" # Tokyo

    tags = {
      Name    = "Jenkins Infra Setup"
      Section = "2"
    }

  }
}
