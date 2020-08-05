
resource "aws_instance" "wwws_jks_ci_cd" {
  ami           = "ami-01819babfeb403eca"
  instance_type = "	c5.2xlarge"
  subnet_id     = "subnet-b36ef198"
  associate_public_ip_address	= "true"
  key_name	    = "aws_commvault"
   security_groups    = [aws_security_group.wwws_jks_ci_cd.id]
//  load_balancers = ["${aws_elb.my-elb.name}"]
  tags = {
        Name = "DEV Teste Infraesturura Agil"
        Projeto = "Infraestrutura como codigo"
        Setor = "DTI"
    }
    user_data = <<EOF
<script>
  winrm quickconfig -q & winrm set winrm/config @{MaxTimeoutms="1800000"} & winrm set winrm/config/service @{AllowUnencrypted="true"} & winrm set winrm/config/service/auth @{Basic="true"}
</script>
<powershell>
  Set-ExecutionPolicy Unrestricted -Scope Process -Force;
  Copy-Item -Path \\10.55.5.2\Arquivos\Magister\* -Destination c:\unit\ -recurse -force
</powershell>
EOF
  }
output "aws_ip" {
    value = aws_instance.wwws_jks_ci_cd.public_ip
}

output "aws_dns" {
    value = aws_instance.wwws_jks_ci_cd.public_dns
}

