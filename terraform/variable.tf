variable "region" {
  default = "us-west-2"
}

variable "account_no" {  
}

variable "default_tags" {
  type = map
}

variable "profile"{}

variable "name" {}

variable "environment" {}

variable "BitBucketSourceRepo" {}

variable "BitBucketBranch" {}

variable "BitBucketToken" {}

variable "BitBucketUser" {}

variable "CodeBuildDockerImage" {}

#variable "KubectlRoleName" {}

variable "pipeline_artifact_bucket" {}

variable "mwaa_bucket" {}
