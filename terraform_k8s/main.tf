provider "aws" {
  region = "us-west-2"
  #access_key = "my-access-key"
  #secret_key = "my-secret-key"
  profile = "target"
}

terraform {
  backend "s3" {
    bucket = "s3-eks-cicd"
    key = "datalake/dev_k8s/terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "eks-cicd-terraform-k8s-state-locks"
    encrypt = true
    profile = "target"
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  #load_config_file       = false
  #version                = "~> 1.10"
}

data "aws_eks_cluster" "cluster" {
  name = "test-eks-dev"
}

data "aws_eks_cluster_auth" "cluster" {
  name = "test-eks-dev"
}