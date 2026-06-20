variable "cluster_name" {

  type = string

}


variable "subnet_ids" {

  type = list(string)

}


variable "node_group_name" {

  default = "accor-node-group"

}
