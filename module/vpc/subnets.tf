resource "aws_subnet" "public" {
  for_each                = toset(data.aws_availability_zones.available.names)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, index(data.aws_availability_zones.available.names, each.key))
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-${index(data.aws_availability_zones.available.names, each.key) + 1}"
  }
}

resource "aws_subnet" "private" {
  for_each          = toset(data.aws_availability_zones.available.names)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, index(data.aws_availability_zones.available.names, each.key) + length(data.aws_availability_zones.available.names))
  availability_zone = each.key

  tags = {
    Name = "${var.project_name}-private-subnet-${index(data.aws_availability_zones.available.names, each.key) + 1}"
  }
}
