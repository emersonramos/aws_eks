variable "vpc_name" {
    default = "eks-vpc"
}

variable "aws_region" {
    default = "us-east-1"
}

variable "cluster_name" {
    default = "eks"
}

variable "kubeversion" {
    default = "1.21"
}

variable "nodes_instances_sizes" {
  default = [
    "t2.micro"
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