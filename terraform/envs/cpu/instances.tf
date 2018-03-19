resource "aws_instance" "ml-t2-01" {
  ami = "ami-9e1a35ed"
  instance_type = "t2.micro"
  key_name = "ec2user-key"
  security_groups = ["allow_ssh_jupyter"]
  tags {
    Name = "ml-t2-01"
  }
}

