resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = merge (
    var.common_tags, 
    var.vpc_tags,
    {
      Name = local.name
    }
  )

}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.common_tags,
    var.igw_tags,
    {
      Name = local.name
    }
    
  )
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnets_cidr[count.index]
  availability_zone = local.az_names[count.index]
  tags =merge (
    var.common_tags,
    var.public_subnets_tags,
    {
      Name = "${local.name}-public-${local.az_names[count.index]}"
    }
  )
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnets_cidr[count.index]
  availability_zone = local.az_names[count.index]
  tags =merge (
    var.common_tags,
    var.public_subnets_tags,
    {
      Name = "${local.name}-private-${local.az_names[count.index]}"
    }
  )
}

resource "aws_subnet" "database" {
  count = length(var.database_subnets_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnets_cidr[count.index]
  availability_zone = local.az_names[count.index]
  tags =merge (
    var.common_tags,
    var.database_subnets_tags,
    {
      Name = "${local.name}-database-${local.az_names[count.index]}"
    }
  )
}

resource "aws_eip" "eip" {
  domain           = "vpc"
}

resource "aws_nat_gateway" "main" {
  allocation_id = "${aws_eip.eip.id}"
  subnet_id     = aws_subnet.public[0].id 

  tags = merge(
    var.common_tags,  
    var.nat_gateway_tags,
    {
      Name = "${local.name}"
    }
  )
  depends_on = ["aws_internet_gateway.gw"]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  
  tags = merge(
    var.common_tags,
    var.public_route_table_tags,
    {
      Name = "${local.name}-public"
    }

  )
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  
  tags = merge(
    var.common_tags,
    var.private_route_table_tags,
    {
      Name = "${local.name}-private"
    }

  )
}

resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  
  tags = merge(
    var.common_tags,
    var.database_route_table_tags,
    {
      Name = "${local.name}-database"
    }

  )
}

resource "aws_route" "public_route" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "10.0.0.0/0"
  gateway_id = aws_internet_gateway.gw
}