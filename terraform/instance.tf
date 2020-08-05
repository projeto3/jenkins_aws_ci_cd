
resource "aws_instance" "wwws_jks_ci_cd" {
  ami           = "ami-01819babfeb403eca"
  instance_type = "m4.2xlarge"
//  spot_price    = "0.2"
  subnet_id     = "subnet-b36ef198"
  associate_public_ip_address	= "false"
  key_name	    = "aws_commvault"
   vpc_security_group_ids = [ "sg-a71e05c3" ]
//  load_balancers = ["${aws_elb.my-elb.name}"]
  tags = {
        Name = "DEV Teste Infraesturura Agil"
        Projeto = "Infraestrutura como codigo"
        Setor = "DTI"
    }
    user_data = <<EOF
<script>
xcopy \\10.51.5.116\Temp\*.* c:\unit\
</script>
<powershell>
  Set-ExecutionPolicy Unrestricted -Scope Process -Force;
  Copy-Item -Path \\10.51.5.116\Temp\ -Destination c:\unit\ -recurse -force
</powershell>
EOF
  }
output "aws_ip" {
    value = aws_instance.wwws_jks_ci_cd.private_ip
}

output "aws_dns" {
    value = aws_instance.wwws_jks_ci_cd.private_dns
}

