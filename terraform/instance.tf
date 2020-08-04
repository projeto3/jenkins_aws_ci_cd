
resource "aws_instance" "wwws_jks_ci_cd" {
  ami           = "ami-6871a115"
  instance_type = "t2.micro"
//  subnet_id     = "subnet-b36ef198"
  key_name	    = "aws_commvault"
//  load_balancers = ["${aws_elb.my-elb.name}"]
}
