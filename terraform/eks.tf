#Create EKS cluster
resource "aws_eks_cluster" "main" {
  name     = "${var.name}-${var.environment}"
  role_arn = aws_iam_role.eks_cluster_role.arn

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    subnet_ids = [data.aws_subnet.private_subnet.id, data.aws_subnet.private_subnet1.id]
    endpoint_private_access = true
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

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "test-eks"
  node_role_arn   = aws_iam_role.eks_cluster_role.arn
  subnet_ids      = [data.aws_subnet.private_subnet.id, data.aws_subnet.private_subnet1.id]
  instance_types = ["t3.xlarge"]
  disk_size = "80"

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  remote_access {
    source_security_group_ids = [aws_security_group.eks_node_security_group.id]
    ec2_ssh_key = var.ec2_ssh_key
  }

  /*taint {
    key = "app"
    value = "airflow"
    effect = "NO_SCHEDULE"
  }*/

  labels = {
    "app" = "airflow"
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
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
