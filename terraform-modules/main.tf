module "iam" {
    source = "./tfmodules/iam"

    group = "group1"
  
}

module "ec2" {
    source = "./tfmodules/ec2"
    az = "us-east-1b"
    instancename = module.iam.username
    vpcsg = module.security-groups.sg-name

    depends_on = [module.iam]
}

module "security-group" {
    source = "./tfmodules/security-groups"
    vpc = "vpc-03037c342ae504b56"
    sg-name = "atlas-SG-2"

}

module "backend" {
    source = "./tfmodules/backend"
    rsa = "aws:kms"
    version-status = "Disabled"
    s3-bucket-2 = "shadi-tf-module-bucket"
    dynamodb-name = "dynamo-db-1"
  
}