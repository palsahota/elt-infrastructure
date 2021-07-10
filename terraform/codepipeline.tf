/*resource "aws_codebuild_project" "build_eks" {
  name          = "build_eks"
  description   = "build_eks"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuildservicerole.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = var.CodeBuildDockerImage
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode = true

    environment_variable {
      name  = "Name"
      value = "${aws_ecr_repository.repo.arn}"
    }

    environment_variable {
      name  = "REPOSITORY_NAME"
      value = "${var.BitBucketSourceRepo}"
    }

    environment_variable {
      name  = "REPOSITORY_BRANCH"
      value = "${var.BitBucketBranch}"
    }

    environment_variable {
      name  = "EKS_CLUSTER_NAME"
      value = "${aws_eks_cluster.main.id}"
    }

    environment_variable {
      name  = "EKS_KUBECTL_ROLE_ARN"
      value = "${aws_iam_role.eks_cluster_role.arn}"
    }

    environment_variable {
      name  = "REPOSITORY_URI"
      value = "${aws_ecr_repository.repo.repository_url}"
    }
  }

  source {
    type            = "CODEPIPELINE"
  }

}

resource "aws_codepipeline" "build_eks_pipeline" {
  name     = "build_eks_pipeline"
  role_arn = aws_iam_role.codepipelineservicerole.arn

  artifact_store {
    location = aws_s3_bucket.pipeline_artifact_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "BitBucket"
      version          = "1"
      output_artifacts = ["App"]

      /*configuration = {
        Owner = "${var.BitBucketUser}"
        Repo = "${var.BitBucketSourceRepo}"
        Branch =  "${var.BitBucketBranch}"
        OAuthToken = "${var.BitBucketToken}"
      }*/
      /*configuration = {
        ConnectionArn    = "arn:aws:codestar-connections:us-west-2:889146076393:connection/a6ea1da5-4658-497f-9586-7588c8c5159d"
        FullRepositoryId = "vgoel88/test-eks"
        BranchName       = "master"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["App"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = "${aws_codebuild_project.build_eks.id}"
      }
    }
  }

  depends_on = [aws_codebuild_project.build_eks]
}*/