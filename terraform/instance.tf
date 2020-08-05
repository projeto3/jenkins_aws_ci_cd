
resource "aws_instance" "wwws_jks_ci_cd" {
  ami           = "ami-021dba0a16646b46e"
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
"xcopy \\10.51.5.116\Temp\*.* c:\unit\"
net user /add developer myP@ssworD1
net localgroup administrators developer /add
</script>
<powershell>
"Set-ExecutionPolicy Unrestricted -Scope Process -Force",
"Copy-Item -Path \\10.51.5.116\Temp\ -Destination c:\unit\ -recurse -force",
"Invoke-RestMethod -uri http://169.254.169.254/latest/user-data $file = $env:SystemRoot + "\Temp\" + (Get-Date).ToString("MM-dd-yy-hh-mm")",
"New-Item $file -ItemType file"
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

