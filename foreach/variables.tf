variable "instance_names" {
    type = map
    default = {
        mongodb = "t3.small"
        catalogue = "t2.micro"
        mysql = "t3.small"
        cart = "t2.micro"
        redis = "t2.micro"
        rabbitmq = "t2.micro"
        cart = "t2.micro"
        user = "t2.micro"
        shippimg = "t3.small"
        dispatch = "t2.micro"
        web = "t2.micro"
    }
    
  
}

variable "ami_id" {
    default = "ami-03265a0778a880afb"
    type = string
  
}

variable "zone_id" {
    default = "Z01756442QKET14NG09F4"
  
}

variable "domain_name" {
    default = "allmydevops.online"
      
}