#MWAA security group.
#Please modify the ingress security group rules as per the requirement
resource "aws_security_group" "mwaa_security_group" {
  name        = "mwaa_security_group"
  description = "Security group for MWAA"
  vpc_id      = "${data.aws_vpc.main.id}"


  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  
  tags = var.default_tags
}