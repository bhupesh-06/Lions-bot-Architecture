module "vpc" {
  source               = "./vpc"
  environment          = "EKS-Cluster"
  vpc_cidr             = "192.168.0.0/16"
  public_subnets_cidr  = ["192.168.1.0/24", "192.168.2.0/24"]
  private_subnets_cidr = ["192.168.3.0/24", "192.168.4.0/24"]
  availability_zones   = ["eu-west-1a", "eu-west-1b"]
}

module "eks" {
  source           = "./eks"
  iam-role         = "eks-cluster-demo1"
  cluster_name     = "demo-eks"
  node_group_name  = "eks-cluster-demo"
   node_group_name1  = "eks-cluster-demo1"
  public_subnet_1  = module.vpc.public-subnet-id-1
  public_subnet_2  = module.vpc.public-subnet-id-2
  private_subnet_1 = module.vpc.private-subnet-id-1
  private_subnet_2 = module.vpc.private-subnet-id-2
}


module "rds" {
  source = "./rds"
  depends_on       = [ module.eks , module.vpc]
  vpc_id           = module.vpc.vpc-id
  instance_class   = "db.t2.micro"
  identifier       = "my-rds"
  username         = "username"
  password         = "12345678"
  engine_version   = "8.0.33"
  engine           = "mysql"
  db_name          = "mydb"
  storage          = "10"
  
}

