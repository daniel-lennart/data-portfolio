resource "aws_instance" "ml-p2-01" {
  ami = "ami-b43d1ec7"
  instance_type = "p2.xlarge"
  key_name = "ec2user-key"
  security_groups = ["allow_ssh_jupyter"]
  tags {
    Name = "ml-p2-01"
  }
}

