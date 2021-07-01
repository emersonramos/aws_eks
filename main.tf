module "network" {
  source = "./modules/network"
  
  vpc_name  = var.vpc_name
  aws_region    = var.aws_region
}

module "controlplane" {
  source = "./modules/controlplane"

  cluster_name  = var.cluster_name
  aws_region    = var.aws_region
  kubeversion   = var.kubeversion

  cluster_vpc   = module.network.eks_vpc
  private_subnet_1a   = module.network.private_subnet_1a
  private_subnet_1b   = module.network.private_subnet_1b
}

module "nodegroup" {
  source = "./modules/nodegroup"

  cluster_name        = var.cluster_name
  aws_region          =  var.aws_region
  kubeversion         = var.kubeversion

  eks_vpc         = module.network.eks_vpc
  private_subnet_1a   = module.network.private_subnet_1a
  private_subnet_1b   = module.network.private_subnet_1b

  eks_cluster         = module.controlplane.eks_cluster
  eks_cluster_sg      = module.controlplane.security_group

  nodes_instances_sizes   = var.nodes_instances_sizes
  auto_scale_options      = var.auto_scale_options
  auto_scale_cpu     = var.auto_scale_cpu
}