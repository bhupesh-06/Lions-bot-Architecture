# Create an IAM role with the AmazonEKSClusterPolicy.
resource "aws_iam_role" "demo-role1" {
  name = var.iam-role1

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "demo-AmazonEKSClusterPolicy1" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.demo-role1.name
}

resource "aws_iam_role_policy_attachment" "demo-AmazonRDSFullAccess1" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
  role       = aws_iam_role.demo-role1.name
}


resource "aws_eks_cluster" "cluster1" {
  name     = var.cluster_name1
  role_arn = aws_iam_role.demo-role1.arn

  vpc_config {
    subnet_ids = [
      var.public1_subnet_1,
      var.public1_subnet_2,
      var.private1_subnet_1,
      var.private1_subnet_2
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.demo-AmazonEKSClusterPolicy1]
}


# Create a single instance group for Kubernetes. Similar to the EKS cluster, it requires an IAM role as well.
resource "aws_iam_role" "nodes1" {
  name = var.node_group_name1


  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy1" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes1.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy1" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes1.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly1" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes1.name
}

resource "aws_eks_node_group" "private1-nodes" {
  cluster_name    = aws_eks_cluster.cluster1.name
  node_group_name = var.node_group_name1
  node_role_arn   = aws_iam_role.nodes1.arn

  subnet_ids = [
    var.private1_subnet_1,
  ]
  

  capacity_type  = "ON_DEMAND"
  instance_types = ["t3.small"]
  disk_size      = 10

  scaling_config {
    desired_size = 6
    max_size     = 8
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "general"
  }
}

resource "aws_eks_node_group" "private1-nodes1" {
  cluster_name    = aws_eks_cluster.cluster1.name
  node_group_name = var.node_group_name1
  node_role_arn   = aws_iam_role.nodes1.arn

  subnet_ids = [
    var.private1_subnet_2
  ]

  capacity_type  = "ON_DEMAND"
  instance_types = ["t3.small"]
  disk_size      = 10

  scaling_config {
    desired_size = 6
    max_size     = 8
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "general"
  }
}

#Create IAM OIDC provider EKS using Terraform
data "tls_certificate" "eks" {
  url = aws_eks_cluster.cluster1.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.cluster1.identity[0].oidc[0].issuer
}
