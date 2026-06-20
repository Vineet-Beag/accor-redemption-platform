resource "aws_iam_role" "eks_cluster" {

  name = "${var.cluster_name}-role"


  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Action = "sts:AssumeRole"

        Effect = "Allow"

        Principal = {

          Service = "eks.amazonaws.com"

        }

      }

    ]

  })

}
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {

  role = aws_iam_role.eks_cluster.name


  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

}
resource "aws_eks_cluster" "main" {

  name = var.cluster_name


  version = var.cluster_version


  role_arn = aws_iam_role.eks_cluster.arn


  vpc_config {

    subnet_ids = var.private_subnet_ids


    endpoint_private_access = true

    endpoint_public_access = false

  }


  depends_on = [

    aws_iam_role_policy_attachment.eks_cluster_policy

  ]

}
