provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "ssh_traffic" {
  name        = "ssh_traffic"
  description = "Allow SSH inbound traffic"
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    git_commit           = "091c8177a523a790938f11ef33e179310b97880f"
    git_file             = "terraform/aws/ec2-for-drift.tf"
    git_last_modified_at = "2021-10-22 05:34:36"
    git_last_modified_by = "fefefe@gmail.com"
    git_modifiers        = "fefefe"
    git_org              = "fefefe8888"
    git_repo             = "terragoat"
    yor_trace            = "9e193856-d2fb-4ceb-b7fe-ca83303d136e"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "091c8177a523a790938f11ef33e179310b97880f"
    git_file             = "terraform/aws/ec2-for-drift.tf"
    git_last_modified_at = "2021-10-22 05:34:36"
    git_last_modified_by = "fefefe@gmail.com"
    git_modifiers        = "fefefe"
    git_org              = "fefefe8888"
    git_repo             = "terragoat"
    yor_trace            = "200e50b2-be26-416c-8a30-62f54a067b79"
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
