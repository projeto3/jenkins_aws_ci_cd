resource "aws_security_group" "wwws_jks_ci_cd" {
  name        = "allow_http"
  description = "Allow http inbound traffic"
  vpc_id      = "vpc-61898804"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
