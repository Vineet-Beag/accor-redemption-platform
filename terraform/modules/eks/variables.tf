variable "cluster_name" {

  description = "EKS cluster name"

  default = "accor-redemption-eks"

}


variable "cluster_version" {

  description = "Kubernetes version"

  default = "1.31"

}


variable "private_subnet_ids" {

  description = "Private subnet IDs"

  type = list(string)

}
