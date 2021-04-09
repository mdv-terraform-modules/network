#-=-=-=-=-=-=-=-=-=-=-=-=-=-=- VPC -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags                 = merge(var.tags, { Name = "Main VPC ${var.environment}" })
}
#-=-=-=-=-=-=-=-=-=-=-=-=-=- Subnets -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_cidr_blocks)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_cidr_blocks, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags                    = merge(var.tags, { Name = "${var.public_subnet_names[count.index]} ${var.environment}" })
}
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_cidr_blocks)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_cidr_blocks, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags              = merge(var.tags, { Name = "${var.private_subnet_names[count.index]} ${var.environment}" })
}
resource "aws_subnet" "db_subnets" {
  count             = length(var.db_cidr_blocks)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.db_cidr_blocks, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags              = merge(var.tags, { Name = "${var.db_subnet_names[count.index]} ${var.environment}" })
}
#-=-=-=-=-=-=-=-=-=-=-=-=- Internet Gateway -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = merge(var.tags, { Name = "Internet Gateway ${var.environment}" })
}
#-=-=-=-=-=-=-=-=-=-=-=-=-=- Route Tables -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = local.any_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(var.tags, { Name = "Route Table for ${var.environment} Public Subnets" })
}

resource "aws_route_table_association" "internet_access_for_public_subnets" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_rt.id
}
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
