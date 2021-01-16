provider "aws" {
  region = "eu-north-1"
}

data "aws_availability_zones" "working" {}
data "aws_region" "current" {}
data "aws_vpcs" "foo" {}
data "aws_vpc" "foo" {}

resource "aws_subnet" "prod_subnet_1" {
  vpc_id =  data.aws_vpc.foo.id
  availability_zone = data.aws_availability_zones.working.names[0]
  cidr_block = "172.31.10.0/24"
  tags = {
    Name = "Subnet-1 in ${data.aws_availability_zones.working.names[0]}"
    Region = data.aws_region.current.name
  }
}

resource "aws_subnet" "prod_subnet_2" {
  vpc_id =  data.aws_vpc.foo.id
  availability_zone = data.aws_availability_zones.working.names[1]
  cidr_block = "172.31.11.0/24"
  tags = {
    Name = "Subnet-2 in ${data.aws_availability_zones.working.names[1]}"
    Region = data.aws_region.current.name
  }
}


output "data_aviability_zones" {
  value = data.aws_availability_zones.working.names[0]
}

output "data_aws_region_name" {
  value  = data.aws_region.current.name
}

output "aws_vpcs" {
  value = data.aws_vpcs.foo.ids
}

output "aws_vpc_id" {
  value = data.aws_vpc.foo.id
}

output "aws_cidr" {
  value = data.aws_vpc.foo.cidr_block
}
