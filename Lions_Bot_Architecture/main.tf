

module "vpc" {
  source               = "./Lions-Infra/pro1/vpc"
  environment          = "EKS-Cluster"
  vpc_cidr             = "192.168.0.0/16"
  public_subnets_cidr  = ["192.168.1.0/24", "192.168.2.0/24"]
  private_subnets_cidr = ["192.168.3.0/24", "192.168.4.0/24"]
  availability_zones   = ["ap-southeast-1a", "ap-southeast-1b"]
}


module "eks" {
  source           = "./Lions-Infra/pro1/eks"
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
  source = "./Lions-Infra/pro1/rds"
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

module "alb" {
  source = "./Lions-Infra/pro1/alb"
  depends_on = [ module.vpc , module.eks ]
  vpc_id = module.vpc.vpc-id
  public_subnet = [module.vpc.public-subnet-id-1 , module.vpc.public-subnet-id-2]
  tg_protocol = "HTTP"
  tg_port = "80"
  listener_protocol = "HTTP"
  listener_port = 80
  sg_name = "alb_sg"
  target_id = module.eks.instance_ids
}


module "waf" {
  source = "./Lions-Infra/pro1/waf"
  region = "eu-west-1"
  aws_lb_arn = module.alb.alb_tg
  
}
//perring 


  
module "perring" {
  source ="./Lions-Infra/pro1/perr"
  depends_on = [ module.vpc , module.vpc_module ]
  requester_vpc_id =module.vpc.vpc-id
  requester_region = "eu-west-1"
  vpc_cidr_req =  module.vpc.vpc_cidr_req
  route_table_req = module.vpc.route_table_req

  accpeter_vpc_id = module.vpc_module.vpc1-id
  accepter_region = "ap-southeast-1"
  vpc_cidr_acc = module.vpc_module.vpc_cidr_acc
  route_table_acc = module.vpc_module.route_table_acc

}


//Part 2 for Diffrent Region 
module "vpc_module" {
  source               = "./Lions-Infra/vpc_module"
  environment1          = "EKS-Cluster1"
  vpc1_cidr             = "172.168.0.0/16"
  public_subnets_cidr1  = ["172.168.1.0/24", "172.168.2.0/24"]
  private_subnets_cidr1 = ["172.168.3.0/24", "172.168.4.0/24"]
  availability_zones1   = ["eu-west-1a", "eu-west-1b"] 
}


module "eks_module" {
  source           = "./Lions-Infra/eks_module"
   depends_on       = [module.vpc_module]
  iam-role1         = "eks-cluster-demo1"
  cluster_name1     = "demo-eks1"
  node_group_name1  = "eks-nodes2"
  public1_subnet_1  = module.vpc_module.public1-subnet-id-1
  public1_subnet_2  = module.vpc_module.public1-subnet-id-2
  private1_subnet_1 = module.vpc_module.private1-subnet-id-1
  private1_subnet_2 = module.vpc_module.private1-subnet-id-2
}

module "rds_module" {
  source = "./Lions-Infra/rds_module"
  depends_on = [module.eks_module, module.vpc_module]
  identifier1             = "for-eks1"
  storage1                = "20"
  engine1                 = "mysql"
  engine_version1         = "5.7.21"
  instance_class1        = "db.t2.micro"
  db_name1                = "mydb"
  username1               = "root"
  password1               = "root123"	
  vpc1_id = module.vpc_module.vpc1-id
}

module "alb_module" {
  source = "./Lions-Infra/alb_module"
  depends_on = [module.vpc_module, module.eks_module]
  vpc1_id = module.vpc_module.vpc1-id
  public_subnets1 = [module.vpc_module.public1-subnet-id-1 , module.vpc_module.public1-subnet-id-2]
  tg_protocol1 = "HTTP"
  tg_port1 = "80"
  listener_protocol1 = "HTTP"
  listener_port1 = 80
  sg_name1 = "alb_sg"
  target_id = module.eks_module.instance_ids1
}

module "waf_module" {
  source = "./Lions-Infra/waf_module"
  depends_on = [module.alb_module]
  region = "ap-southeast-1"
  aws_lb_arn1 = module.alb_module.alb_tg1
  
}









