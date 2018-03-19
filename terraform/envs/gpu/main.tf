provider "aws" {
  region = "eu-west-1"
}

resource "aws_key_pair" "ec2user" {
  key_name   = "ec2user-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8xz2uE0fNvtpvtEeTjV7pWncG32vFSb2kyExaxvOkM06bZBJORJWBwkxdzeskQNvjAbpxcIpM2/t3gG1IXDzmlwIMrjl4SJBNJgERhCqlVGl4V7Airw8cy+GZnhAKc8jOSsKCYFLowbGhR/83m6RkVq0zjJT3ewopG1FrYmsf+iBJ7gZ9WNq1z2lqkp3tDiJVXuLHeOiRuYtq6yhNt7sMK8QZsxv9SIUBSUR6YXqLt7cDywRXqbU3N5vPmrMDP+xLdvIZrtxm38Ix/gfmLnDEY3QEvoHjto59CVVQ8KCqL1+znE51e8WvVYYCaYvqRlrjDs8acfGrinqqqRp1CMd9 Daniel.Lennart@UKDUMXDVDWDLEN"
}
