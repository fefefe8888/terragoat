provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "ssh_traffic" {
  name        = "ssh_traffic"
  description = "Allow SSH inbound traffic"
  ingress {
    self        = false
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    git_commit           = "001a8238cf1d5e370c929d2f97aa010c081cdc34"
    git_file             = "simple_instance/ec2.tf"
    git_last_modified_at = "2021-10-22 05:31:06"
    git_last_modified_by = "fefefe@gmail.com"
    git_modifiers        = "fefefe"
    git_org              = "fefefe8888"
    git_repo             = "terragoat"
    yor_trace            = "234617b4-885e-416d-a31d-7d61236ca1c6"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]


  tags = {
    git_commit           = "001a8238cf1d5e370c929d2f97aa010c081cdc34"
    git_file             = "simple_instance/ec2.tf"
    git_last_modified_at = "2021-10-22 05:31:06"
    git_last_modified_by = "fefefe@gmail.com"
    git_modifiers        = "fefefe"
    git_org              = "fefefe8888"
    git_repo             = "terragoat"
    yor_trace            = "e302ba60-b6ee-4ece-ac78-ca0fcf7534d7"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
