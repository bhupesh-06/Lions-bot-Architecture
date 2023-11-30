
module "vpc" {
  source               = "./Module_1/vpc"
  environment          = "EKS-Cluster"
  vpc_cidr             = "192.168.0.0/16"
  public_subnets_cidr  = ["192.168.1.0/24", "192.168.2.0/24"]
  private_subnets_cidr = ["192.168.3.0/24", "192.168.4.0/24"]
  availability_zones   = ["eu-west-1a", "eu-west-1b"]
}


module "eks" {
  source           = "./Module_1/eks"
  depends_on = [ module.vpc ]
  iam-role         = "eks-cluster-demo"
  cluster_name     = "demo-eks"
  node_group_name  = "eks-nodes2"
  node_group_name1 = "eks-nodes1"
  public_subnet_1  = module.vpc.public-subnet-id-1
  public_subnet_2  = module.vpc.public-subnet-id-2
  private_subnet_1 = module.vpc.private-subnet-id-1
  private_subnet_2 = module.vpc.private-subnet-id-2
}

module "rds" {
  source = "./Module_1/rds"
  depends_on = [ module.vpc, module.eks ]
  identifier             = "for-eks"
  storage                = "20"
  engine                 = "mysql"
  engine_version         = "5.7.21"
  instance_class         = "db.t2.micro"
  db_name                = "mydb"
  username               = "root"
  password               = "root123"	
  vpc_id = module.vpc.vpc-id
}

module "vpc_module" {
  source               = "./Module_2/vpc_module"
  environment          = "EKS-Cluster"
  vpc_cidr             = "192.168.0.0/16"
  public_subnets_cidr  = ["192.168.1.0/24", "192.168.2.0/24"]
  private_subnets_cidr = ["192.168.3.0/24", "192.168.4.0/24"]
  availability_zones   = ["ap-southeast-1a", "ap-southeast-1b"]
}


module "EKS_module" {
  source           = "./Module_2/EKS_module"
  depends_on       = [ module.vpc_module]
  iam-role         = "eks-cluster-demo"
  cluster_name     = "demo-eks"
  node_group_name  = "eks-nodes2"
  node_group_name1 = "eks-nodes1"
  public_subnet_1  = module.vpc.public-subnet-id-1
  public_subnet_2  = module.vpc.public-subnet-id-2
  private_subnet_1 = module.vpc.private-subnet-id-1
  private_subnet_2 = module.vpc.private-subnet-id-2
}

module "rds_module" {
  source = "./Module_2/rds_module"
  depends_on = [module.EKS_module , module.vpc_module]
  identifier             = "for-eks"
  storage                = "20"
  engine                 = "mysql"
  engine_version         = "5.7.21"
  instance_class         = "db.t2.micro"
  db_name                = "mydb"
  username               = "root"
  password               = "root123"	
  vpc_id = module.vpc.vpc-id
}

module "VPC-perring" {
  source ="./Module_3/vpc_peering"
  accpeter_vpc_id = module.vpc.vpc_cidr
  accepter_region = "eu-west-1"
  vpc_cidr_acc = Module_1.vpc_cidr_acc
  route_table_acc = Module_1.module.vpc.route_table_acc
  requester_vpc_id = "ap-southeast-1"
  requester_region =  Module_2.vpc_cidr
  vpc_cidr_req =  Module_2.vpc_cidr
  route_table_req = Module_2.module.vpc.route_table_req
  }
  
module "perring" {
  source ="./perr"
  depends_on = [ module.vpc , module.vpc1 ]
  requester_vpc_id =module.vpc.vpc-id
  requester_region ="ap-southeast-1"
  vpc_cidr_req =  module.vpc.vpc_cidr
  route_table_req = module.vpc.route_table_req

  accpeter_vpc_id = module.vpc1.vpc1-id
  accepter_region = "eu-west-1"
  vpc_cidr_acc = module.vpc1.vpc1_cidr
  route_table_acc = module.vpc1.route_table_acc

}
