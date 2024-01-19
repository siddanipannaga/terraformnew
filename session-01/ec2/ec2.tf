resource "aws_instance" "web" {
  ami           = "ami-03265a0778a880afb" #devops practise 
  instance_type = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.roboshop-all.id ]
  tags = {
    Name = "HelloTerraform"
  }
}
resource "aws_security_group" "roboshop-all" { # this is terraform name
    name        = var.sg-name # this is aws name
    description = var.sg-description
   # vpc_id      = aws_vpc.main.id # this is optional
   ingress {
    description      = var.sg-description
    from_port        = var.inbound from_port # means all ports
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = var.cidr_blocks    
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "roboshop-all-aws"
  }

}