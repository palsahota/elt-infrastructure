provider "aws" {
  region = "us-west-2"
  #access_key = "my-access-key"
  #secret_key = "my-secret-key"
  profile = "default"
}

terraform {
  backend "s3" {
    bucket = "s3-eks-cicd"
    key = "devops-eks-cicd/dev/terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "eks-cicd-terraform-state-locks"
    encrypt = true
    profile = "default"
  }
}

data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.main.id
}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.main.id
}

provider "local" {
  version = "~> 1.4"
}

provider "template" {
  version = "~> 2.1"
}

provider "external" {
  version = "~> 1.2"
}