resource "aws_instance" "web" {
    ami           = "ami-03265a0778a880afb"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.roboshop-all.id]
  tags = {
    Name = "provisioner"
  } 

  provisioner "local-exec" {
    command = "echo this will excute at the time of creation, you can trigger other email or alerts"
  }

  provisioner "local-exec" {
    command = "echo  ${self.private_ip} > inventory" # self- aws_instance.web
  }

  # provisioner "local-exec" {
  #   command = "ansible-playbook -i inventory web.yaml" # self- aws_instance.web
  # }

  provisioner "local-exec" {
    command = "echo this will destroy at the time of destroy, you can trigger other emial or alerts"
    when = destroy
  }

  connection {
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
    host     = self.public_ip
  }
  
   provisioner "remote-exec" {
    inline = [
      "echo 'this is remote access' > /tmp/remote.txt",
      "sudo yum install nginx -y",
      "sudo systemctl start nginx"
      
    ]
  }
}


resource "aws_security_group" "roboshop-all"{ 
  name        = "provisioner" 
  ingress {
    description      = "allow all ports"
    from_port        = 22 # means all ports
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [" 0.0.0.0/0"]   
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  ingress {
    description      = "allow all ports"
    from_port        = 80 # means all ports
    to_port          = 80 
    protocol         = "tcp"
    cidr_blocks      = [" 0.0.0.0/0"]   
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
    Name = "provisioner"
  }

}


