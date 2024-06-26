resource "aws_vpc" "faks_vpc" {
    cidr_block = "10.0.0.0/24"

    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
      Name = "faks_vpc"
    }
}

resource "aws_internet_gateway" "Igw" {
  vpc_id = aws_vpc.faks_vpc.id

  tags = {
    Name = "Main_Igw"
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.faks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Igw.id
  }

  tags = {
    Name = "Public_Route_Table"
  }
  
}

resource "aws_subnet" "Public_subnet" {
  vpc_id = aws_vpc.faks_vpc.id
  availability_zone = "us-east-1b"
  cidr_block = "10.0.0.0/28"
  tags = {
    Name = "Public_subnet"
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.faks_vpc.id
  cidr_block              = "10.0.0.16/28"
  availability_zone       = "us-east-1a" # Replace with your desired AZ

  tags = {
    Name = "main-public-subnet-2"
  }
}
resource "aws_route_table_association" "Public_subnet_association" {
  subnet_id = aws_subnet.Public_subnet.id
  route_table_id = aws_route_table.public_route.id  
}

resource "aws_route_table_association" "Public_subnet_association1" {
  subnet_id = aws_subnet.public2.id
  route_table_id = aws_route_table.public_route.id  
}
