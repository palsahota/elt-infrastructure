#Create EKS cluster
resource "aws_eks_cluster" "main" {
  name     = "${var.name}-${var.environment}"
  role_arn = aws_iam_role.eks_cluster_role.arn

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    subnet_ids = [data.aws_subnet.private_subnet.id, data.aws_subnet.private_subnet1.id]
  }

  timeouts {
    delete = "30m"
  }

  depends_on = [
    aws_cloudwatch_log_group.eks_cluster,
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy
  ]
}


#Create a EKS Fargate profile
resource "aws_eks_fargate_profile" "main" {
  cluster_name           = aws_eks_cluster.main.name
  fargate_profile_name   = "fp-default"
  pod_execution_role_arn = aws_iam_role.fargate_pod_execution_role.arn
  subnet_ids             = [data.aws_subnet.private_subnet.id, data.aws_subnet.private_subnet1.id]

  selector {
    namespace = "default"
  }

  selector {
    namespace = "nginx"
  }
}

/*resource "kubernetes_namespace" "fargate" {
  metadata {
    labels = {
      app = "nginx"
    }
    name = "nginx"
  }
}*/

#Create EKS Deployment
/*resource "kubernetes_deployment" "app" {
  metadata {
    name      = "deployment-nginx"
    namespace = "nginx"
    labels    = {
      app = "nginx"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          image = "nginx"
          name  = "nginx"

          port {
            container_port = 80
          }
        }
      }
    }
  }

  depends_on = [aws_eks_fargate_profile.main]
}*/

#Create an ECR repo
resource "aws_ecr_repository" "repo" {
  name                 = var.name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
