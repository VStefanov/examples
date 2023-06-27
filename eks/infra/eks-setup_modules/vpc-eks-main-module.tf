module "vpc" {
    source = "terraform-aws-modules/vpc/aws"

    name = "eks-main-module"
    cidr = "10.0.0.0/16"

    azs             = ["eu-west-1a", "eu-west-1b"]
    public_subnets  = ["10.0.0.0/19", "10.0.32.0/19"]
    private_subnets = ["10.0.64.0/19", "10.0.96.0/19"]

    enable_dns_hostnames = true
    enable_dns_support   = true

    enable_nat_gateway     = true
    single_nat_gateway     = true
    one_nat_gateway_per_az = false

    public_subnet_tags = {
        "kubernetes.io/role/elb"     = 1
        "kubernetes.io/cluster/test-cluster" = "owned"
    }

    private_subnet_tags = {
        "kubernetes.io/role/internal-elb"     = 1
        "kubernetes.io/cluster/test-cluster" = "owned"
    }
}