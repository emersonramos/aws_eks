variable "aws_region" {}
variable "cluster_name" {}
variable "kubeversion" {}
variable "eks_vpc" {}
variable "private_subnet_1a" {}
variable "private_subnet_1b" {}
variable "eks_cluster" {}
variable "eks_cluster_sg" {}
variable "nodes_instances_sizes" {
  default = [
    "t3.medium"
  ]
}

variable "auto_scale_options" {
  default = {
    min     = 2
    max     = 5
    desired = 2
  }
}

variable "auto_scale_cpu" {
  default = {
    scale_up_threshold  = 70
    scale_up_period     = 60
    scale_up_evaluation = 2
    scale_up_cooldown   = 300
    scale_up_add        = 2

    scale_down_threshold  = 30
    scale_down_period     = 120
    scale_down_evaluation = 2
    scale_down_cooldown   = 300
    scale_down_remove     = -1
  }
}