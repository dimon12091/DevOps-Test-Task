data "terraform_remote_state" "aws_vpc_repository" {
  backend = "s3"
  config  = {
    # Replace this with your bucket name!
    bucket = "terraform-state-${var.project}"
    key    = "vpc/terraform.tfstate"
    region = var.region
  }
}

# EKS Cluster
resource "aws_eks_cluster" "this" {
  name     = "${var.project}-cluster"
  role_arn = aws_iam_role.cluster.arn
  version  = "1.25"

  vpc_config {
    # security_group_ids      = [aws_security_group.eks_cluster.id, aws_security_group.eks_nodes.id]
    subnet_ids              = flatten([data.terraform_remote_state.aws_vpc_repository.outputs.public_subnets_id, data.terraform_remote_state.aws_vpc_repository.outputs.private_subnets_id])
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags
  )

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy
  ]
}
