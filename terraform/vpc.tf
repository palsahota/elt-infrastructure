#Importing the VPC details
data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    #values = ["bidatalake-develop-VpcStack-18Q7AC13YHHQU-vpc"]
    values = ["default-vpc"]
  }
}

#Importing the Private Subnet details in us-west-2c
data "aws_subnet" "private_subnet" {
  vpc_id = data.aws_vpc.main.id

  filter {
    name   = "tag:Network"
    values = ["Private"]
  }

  #availability_zone = "${var.region}a"
  availability_zone = "${var.region}c"
}

#Importing the Private Subnet details in us-west-2d
data "aws_subnet" "private_subnet1" {
  vpc_id = "${data.aws_vpc.main.id}"

  filter {
    name   = "tag:Network"
    values = ["Private"]
  }

  #availability_zone = "${var.region}b"
  availability_zone = "${var.region}d"
}

#Importing the Private Subnet details in us-west-2a
data "aws_subnet" "public_subnet" {
  vpc_id = "${data.aws_vpc.main.id}"

  filter {
    name   = "tag:Network"
    values = ["Public"]
  }

  #availability_zone = "${var.region}b"
  availability_zone = "${var.region}a"
}

#Importing the Private Subnet details in us-west-2b
data "aws_subnet" "public_subnet1" {
  vpc_id = "${data.aws_vpc.main.id}"

  filter {
    name   = "tag:Network"
    values = ["Public"]
  }

  #availability_zone = "${var.region}b"
  availability_zone = "${var.region}b"
}