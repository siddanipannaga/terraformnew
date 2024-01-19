output "public_ip" {
    value = module.roboshop_ec2.public_ip   
  
}

output "private_ip" {
    value = module.roboshop_ec2.private_ip
  
}