
resource "aws_instance" "wwws_jks_ci_cd" {
  ami           = "ami-01819babfeb403eca"
  instance_type = "t2.micro"
  subnet_id     = "subnet-b36ef198"
  associate_public_ip_address	= "true"
  key_name	    = "aws_commvault"
  vpc_security_group_ids = "sg-991899f2"
//  load_balancers = ["${aws_elb.my-elb.name}"]
  tags = {
        Name = "DEV Teste Infraesturura Agil"
        Projeto = "Infraestrutura como codigo"
        Setor = "DTI"
    }
  }
output "aws_ip" {
    value = aws_instance.wwws_jks_ci_cd.public_ip
}

output "aws_dns" {
    value = aws_instance.wwws_jks_ci_cd.public_dns
}
