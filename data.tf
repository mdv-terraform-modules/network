data "aws_availability_zones" "available" {}

data "aws_vpc" "vpc_id" {
  id = aws_vpc.main.id
}

data "aws_subnet_ids" "available" {
  vpc_id = data.aws_vpc.vpc_id.id
}
