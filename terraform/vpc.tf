# Brian Moore, Monetize Solutions, 2021
# References to the public and private subnets in the vpc
data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = [var.main_vpc]
  }
}

data "aws_subnet" "private_subnet1" {
  vpc_id = data.aws_vpc.main.id

  filter {
    name   = "tag:Name"
    values = [var.private_subnet1]
  }

  availability_zone = "${var.region}a"
}

data "aws_subnet" "private_subnet2" {
  vpc_id = "${data.aws_vpc.main.id}"

  filter {
    name   = "tag:Name"
    values = [var.private_subnet2]
  }

  availability_zone = "${var.region}b"
}

data "aws_subnet" "private_subnet3" {
  vpc_id = "${data.aws_vpc.main.id}"

  filter {
    name   = "tag:Name"
    values = [var.private_subnet3]
  }

  availability_zone = "${var.region}c"
}