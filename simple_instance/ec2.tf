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
    git_commit           = "3fa1c00664333c738673701068e1faff750a4c80"
    git_file             = "simple_instance/ec2.tf"
    git_last_modified_at = "2021-10-22 09:28:01"
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

resource "aws_s3_bucket" "data" {
  # bucket is public
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  bucket        = "${local.resource_prefix.value}-data"
  acl           = "public-read"
  force_destroy = true
  tags = {
    git_commit           = "78770b4d55d404031a9f0bc1d2299f6734012975"
    git_file             = "simple_instance/ec2.tf"
    git_last_modified_at = "2021-10-22 11:23:07"
    git_last_modified_by = "fefefe@gmail.com"
    git_modifiers        = "fefefe"
    git_org              = "fefefe8888"
    git_repo             = "terragoat"
    yor_trace            = "1c68e549-c063-4a14-bf4d-4da457cb34fe"
  }
}
