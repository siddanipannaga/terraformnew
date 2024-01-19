variable "ingress_rules" {
    default = [
        {
            description      = "allow port 80"
            from_port        = 80 # means all ports
            to_port          = 80
            protocol         = "tcp"
            cidr_blocks      = ["0.0.0.0/0"] 
        },
        {
            description      = "allow port 3306"
            from_port        = 3306 # means all ports
            to_port          = 3306 
            protocol         = "tcp"
            cidr_blocks      = ["0.0.0.0/0"] 
        },
        {
            description      = "allow port 22"
            from_port        = 22 # means all ports
            to_port          = 22
            protocol         = "tcp"
            cidr_blocks      = ["0.0.0.0/0"] 
        }

    ]
  
}


