resource "aws_eks_node_group" "cluster" {
  
    cluster_name = var.eks_cluster.name
    node_group_name = format("%s-node-group", var.cluster_name)
    node_role_arn = aws_iam_role.eks_nodes_roles.arn

    subnet_ids = [
        var.private_subnet_1a.id,
        var.private_subnet_1b.id
    ]

    instance_types = var.nodes_instances_sizes

    scaling_config {
        desired_size    = lookup(var.auto_scale_options, "desired")
        max_size        = lookup(var.auto_scale_options, "max")
        min_size        = lookup(var.auto_scale_options, "min")
    }

    tags = {
        "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    }

}

data "aws_iam_policy_document" "eks_nodes_role" {
  
    version = "2012-10-17"

    statement {

        actions = [ "sts:AssumeRole" ]

        principals {
            type = "Service"
            identifiers = [
                "ec2.amazonaws.com"
            ]
        }

    }

}

resource "aws_iam_role" "eks_nodes_roles" {
    name = format("%s-eks-nodes", var.cluster_name)
    assume_role_policy = data.aws_iam_policy_document.eks_nodes_role.json
}

resource "aws_iam_role_policy_attachment" "cni" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role = aws_iam_role.eks_nodes_roles.name
}

resource "aws_iam_role_policy_attachment" "node" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role = aws_iam_role.eks_nodes_roles.name
}

resource "aws_iam_role_policy_attachment" "ecr" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role = aws_iam_role.eks_nodes_roles.name
}