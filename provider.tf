provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.default.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.default.token
  }
}
provider "aws" {
  region = "sa-east-1"
}

terraform {
  backend "s3" {
  }
}

data "aws_eks_cluster" "default" {
  name = "eks"
}

data "aws_eks_cluster_auth" "default" {
  name = "eks"
}