module "ec2" {
  source      = "./modules/ec2"
  atlas-sg-id = module.security-groups.atlas-sg-id
  subnet-1    = module.vpc.subnet-1

  depends_on = [
    module.security-groups
  ]

}

module "route-53" {
  source     = "./modules/route-53"
  atlas-vpc  = module.vpc.vpc-id
  private-ip = module.ec2.private-ip

  depends_on = [
    module.vpc,
    module.ec2
  ]
}

module "security-groups" {
  source    = "./modules/security-groups"
  atlas-vpc = module.vpc.vpc-id

  depends_on = [
    module.vpc
  ]

}

module "vpc" {
  source = "./modules/vpc"


}