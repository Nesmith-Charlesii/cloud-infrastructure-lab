resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = var.name
    Environment = var.environment
    Region      = var.region
  }
}

resource "aws_subnet" "public" {
  # Create 1 subnet per public subnet CIDR provided
  # i.e aws_subnet.public[0], aws_subnet.public[1], etc.
  count = length(var.public_subnet_cidrs)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = "${var.name}-public-${count.index + 1}"
    Environment = var.environment
    Region      = var.region
  }
}

resource "aws_subnet" "private" {
  # Create 1 subnet per private subnet CIDR provided
  # i.e aws_subnet.private[0], aws_subnet.private[1], etc.
  count = length(var.private_subnet_cidrs)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = "${var.name}-private-${count.index + 1}"
    Environment = var.environment
    Region      = var.region
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.name}-igw"
    Environment = var.environment
    Region      = var.region
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.name}-public-rt"
    Environment = var.environment
    Region      = var.region
  }
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}