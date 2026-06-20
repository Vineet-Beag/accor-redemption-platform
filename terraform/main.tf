module "vpc" {

  source = "./modules/vpc"

}
module "eks" {

  source = "./modules/eks"


  cluster_name = "accor-redemption-eks"


  private_subnet_ids = module.vpc.private_subnets

}
module "nodegroup" {

  source = "./modules/nodegroup"


  cluster_name = module.eks.cluster_name


  subnet_ids = module.vpc.private_subnets

}
