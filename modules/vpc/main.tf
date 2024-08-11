resource "aws_vpc" "vpc" {
    cidr_block = var.cidr_block
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = var.vpc_name
        Environment = var.environment
    }
}

resource "aws_subnet" "public_subnets" {
    count = length(var.public_subnets)
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnets[count.index]
    availability_zone = var.availability_zones[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.vpc_name}-public-${count.index + 1}"
        Environment = var.environment
    }
}

resource "aws_subnet" "private_subnets" {
    count = length(var.private_subnets)
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnets[count.index]
    availability_zone = var.availability_zones[count.index]

    tags = {
        Name = "${var.vpc_name}-private-${count.index + 1}"
        Environment = var.environment
    }
}

resource "aws_internet_gateway" "vpc-igw" {
    vpc_id = aws_vpc.vpc.id

    tags = {
      Name = "${var.vpc_name}-igw"
      Environment = var.environment
    }
}

resource "aws_eip" "eip-nat" {
    count = length(var.public_subnets)
    domain = "vpc"

    tags = {
      Name = "${var.vpc_name}-eip-nat-${count.index + 1}"
      Environment = var.environment
    }
}

resource "aws_nat_gateway" "vpc-nat" {
    count = length(var.public_subnets)
    allocation_id = aws_eip.eip-nat[count.index].id
    subnet_id = aws_subnet.public_subnets[count.index].id

    tags = {
        Name = "${var.vpc_name}-nat-${count.index + 1}"
        Environment = var.environment
    }
}


resource "aws_route_table" "vpc-public-rt" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.vpc-igw.id
    }

    tags = {
        Name = "${var.vpc_name}-public-rt"
        Environment = var.environment
    }
}

resource "aws_route_table_association" "vpc-public-rt" {
    count = length(aws_subnet.public_subnets[*].id)
    subnet_id   =  aws_subnet.public_subnets[count.index].id
    route_table_id = aws_route_table.vpc-public-rt.id
}

resource "aws_route_table" "vpc-private-rt" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id =  element(aws_nat_gateway.vpc-nat[*].id, 0)
    }

    tags = {
        Name = "${var.vpc_name}-private-rt"
        Environment = var.environment
    }
}

resource "aws_route_table_association" "vpc-private-rt" {
    count = length(aws_subnet.private_subnets[*].id)
    subnet_id   = aws_subnet.private_subnets[count.index].id
    route_table_id = aws_route_table.vpc-private-rt.id
}



