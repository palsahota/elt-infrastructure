resource "kubernetes_namespace" "fargate" {
  metadata {
    labels = {
      app = "eks-cicd"
    }
    name = "eks-cicd"
  }
}

resource "kubernetes_service_account" "test_service" {
  metadata {
    name = "service-account"
  }
  secret {
    name = "${kubernetes_secret.test_secret.metadata.0.name}"
  }
}

resource "kubernetes_secret" "test_secret" {
  metadata {
    name = "basic-auth"
  }

  data = {
    username = "admin"
    password = "P4ssw0rd"
  }

  type = "kubernetes.io/basic-auth"
}