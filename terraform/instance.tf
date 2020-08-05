
resource "aws_instance" "wwws_jks_ci_cd" {
  ami           = "ami-047b5db0ac549fd6b"
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
Set-ExecutionPolicy Unrestricted -Scope LocalMachine -Force -ErrorAction Ignore
mkdir c:\devops
xcopy \\10.51.5.116\Temp\*.* c:\devops\
net user /add developer myP@ssworD1
net localgroup administrators developer /add
%WINDIR%\System32\WindowsPowerShell\v1.0\powershell.exe -Command "& {(New-Object System.Net.WebClient).DownloadFile('https://github.com/projeto3/jenkins_aws_ci_cd/archive/master.zipe', 'C:\unit')}
</script>
<powershell>
Set-ExecutionPolicy Unrestricted -Scope Process -Force
(New-Object System.Net.WebClient).DownloadFile('https://github.com/projeto3/jenkins_aws_ci_cd/archive/master.zipe', 'C:\unit')

Copy-Item -Path \\10.51.5.116\Temp\ -Destination c:\devops\ -recurse -force
</powershell>
<persist>true</persist>
EOF
  }
output "aws_ip" {
    value = aws_instance.wwws_jks_ci_cd.private_ip
}

output "aws_dns" {
    value = aws_instance.wwws_jks_ci_cd.private_dns
}

