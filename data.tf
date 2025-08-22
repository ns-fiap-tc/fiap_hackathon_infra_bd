data "aws_eks_cluster" "hacka_cluster" {
  name = "hacka_cluster"
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.aws_eks_cluster.hacka_cluster.name
}

data "aws_eks_cluster_auth" "hacka_cluster_auth" {
  name = data.aws_eks_cluster.hacka_cluster.name
}

data "aws_vpc" "hacka_vpc" {
  filter {
    name   = "cidr"
    values = ["10.0.0.0/16"]
  }

  filter {
    name   = "tag:Name"
    values = ["hacka_vpc"]
  }
}

data "aws_subnet" "hacka_private_subnet_1" {
  filter {
    name   = "tag:Name"
    values = ["hacka_private_subnet_1"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.hacka_vpc.id]
  }

  filter {
    name   = "cidrBlock"
    values = ["10.0.3.0/24"]
  }
}

data "aws_subnet" "hacka_private_subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["hacka_private_subnet_2"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.hacka_vpc.id]
  }

  filter {
    name   = "cidrBlock"
    values = ["10.0.4.0/24"]
  }
}