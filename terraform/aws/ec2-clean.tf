resource "aws_instance" "web_host" {
  # ec2 have plain text secrets in user data
  ami           = "${var.ami}"
  instance_type = "t2.nano"

  vpc_security_group_ids = [
  "${aws_security_group.web-node.id}"]
  subnet_id = "${aws_subnet.web_subnet.id}"
  user_data = <<EOF
#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMAAA
export AWS_SECRET_ACCESS_KEY=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
export AWS_DEFAULT_REGION=us-west-2
echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
EOF
  tags = {
    git_commit           = "d4e24fe7a0a581f3bfa744261636d6be1ea8bd9d"
    git_file             = "terraform/aws/ec2-clean.tf"
    git_last_modified_at = "2021-10-22 04:14:24"
    git_last_modified_by = "fefefe@gmail.com"
    git_modifiers        = "fefefe"
    git_org              = "fefefe8888"
    git_repo             = "terragoat"
    yor_trace            = "601d66cf-6f3f-43b6-a959-9f4e605a5485"
  }
}

resource "aws_ebs_volume" "web_host_storage" {
  # unencrypted volume
  availability_zone = "${var.region}a"
  #encrypted         = false  # Setting this causes the volume to be recreated on apply 
  size      = 1
  encrypted = true
  tags = {
    git_commit           = "d4e24fe7a0a581f3bfa744261636d6be1ea8bd9d"
    git_file             = "terraform/aws/ec2-clean.tf"
    git_last_modified_at = "2021-10-22 04:14:24"
    git_last_modified_by = "fefefe@gmail.com"
    git_modifiers        = "fefefe"
    git_org              = "fefefe8888"
    git_repo             = "terragoat"
    yor_trace            = "a5614704-59a5-48fc-ab4f-291c6cea63dd"
  }
}

resource "aws_ebs_snapshot" "example_snapshot" {
  # ebs snapshot without encryption
  volume_id   = "${aws_ebs_volume.web_host_storage.id}"
  description = "${local.resource_prefix.value}-ebs-snapshot"
  tags = {
    git_commit           = "d4e24fe7a0a581f3bfa744261636d6be1ea8bd9d"
    git_file             = "terraform/aws/ec2-clean.tf"
    git_last_modified_at = "2021-10-22 04:14:24"
    git_last_modified_by = "fefefe@gmail.com"
    git_modifiers        = "fefefe"
    git_org              = "fefefe8888"
    git_repo             = "terragoat"
    yor_trace            = "8997e896-f36e-49b4-8a7c-8d4aebee7514"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.web_host_storage.id}"
  instance_id = "${aws_instance.web_host.id}"
}

resource "aws_security_group" "web-node" {
  # security group is open to the world in SSH port
  name        = "${local.resource_prefix.value}-sg"
  description = "${local.resource_prefix.value} Security Group"
  vpc_id      = aws_vpc.web_vpc.id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  depends_on = [aws_vpc.web_vpc]
  tags = {
    git_commit           = "d4e24fe7a0a581f3bfa744261636d6be1ea8bd9d"
    git_file             = "terraform/aws/ec2-clean.tf"
    git_last_modified_at = "2021-10-22 04:14:24"
    git_last_modified_by = "fefefe@gmail.com"
    git_modifiers        = "fefefe"
    git_org              = "fefefe8888"
    git_repo             = "terragoat"
    yor_trace            = "3214f7b8-bf59-4883-aa68-9b8ec773a421"
  }
}

resource "aws_vpc" "web_vpc" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    git_commit           = "d4e24fe7a0a581f3bfa744261636d6be1ea8bd9d"
    git_file             = "terraform/aws/ec2-clean.tf"
    git_last_modified_at = "2021-10-22 04:14:24"
    git_last_modified_by = "fefefe@gmail.com"
    git_modifiers        = "fefefe"
    git_org              = "fefefe8888"
    git_repo             = "terragoat"
    yor_trace            = "c53955fa-84c1-4a13-8adf-1273df476c50"
  }
}

resource "aws_subnet" "web_subnet" {
  vpc_id                  = aws_vpc.web_vpc.id
  cidr_block              = "172.16.10.0/24"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true
  tags = {
    git_commit           = "d4e24fe7a0a581f3bfa744261636d6be1ea8bd9d"
    git_file             = "terraform/aws/ec2-clean.tf"
    git_last_modified_at = "2021-10-22 04:14:24"
    git_last_modified_by = "fefefe@gmail.com"
    git_modifiers        = "fefefe"
    git_org              = "fefefe8888"
    git_repo             = "terragoat"
    yor_trace            = "1d5d091b-bd99-43c0-ab6e-c94a2bc6d0c2"
  }
}

resource "aws_subnet" "web_subnet2" {
  vpc_id                  = aws_vpc.web_vpc.id
  cidr_block              = "172.16.11.0/24"
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true
  tags = {
    git_commit           = "d4e24fe7a0a581f3bfa744261636d6be1ea8bd9d"
    git_file             = "terraform/aws/ec2-clean.tf"
    git_last_modified_at = "2021-10-22 04:14:24"
    git_last_modified_by = "fefefe@gmail.com"
    git_modifiers        = "fefefe"
    git_org              = "fefefe8888"
    git_repo             = "terragoat"
    yor_trace            = "d5f4f353-bb30-4f4b-8781-52e615739653"
  }
}


resource "aws_internet_gateway" "web_igw" {
  vpc_id = aws_vpc.web_vpc.id

  tags = {
    git_commit           = "d4e24fe7a0a581f3bfa744261636d6be1ea8bd9d"
    git_file             = "terraform/aws/ec2-clean.tf"
    git_last_modified_at = "2021-10-22 04:14:24"
    git_last_modified_by = "fefefe@gmail.com"
    git_modifiers        = "fefefe"
    git_org              = "fefefe8888"
    git_repo             = "terragoat"
    yor_trace            = "b4ecb4db-6a40-451d-b1c6-1c0287ace237"
  }
}

resource "aws_route_table" "web_rtb" {
  vpc_id = aws_vpc.web_vpc.id

  tags = {
    git_commit           = "d4e24fe7a0a581f3bfa744261636d6be1ea8bd9d"
    git_file             = "terraform/aws/ec2-clean.tf"
    git_last_modified_at = "2021-10-22 04:14:24"
    git_last_modified_by = "fefefe@gmail.com"
    git_modifiers        = "fefefe"
    git_org              = "fefefe8888"
    git_repo             = "terragoat"
    yor_trace            = "db7a81a2-fe3c-427f-9fdf-404a694342bc"
  }
}

resource "aws_route_table_association" "rtbassoc" {
  subnet_id      = aws_subnet.web_subnet.id
  route_table_id = aws_route_table.web_rtb.id
}

resource "aws_route_table_association" "rtbassoc2" {
  subnet_id      = aws_subnet.web_subnet2.id
  route_table_id = aws_route_table.web_rtb.id
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.web_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.web_igw.id

  timeouts {
    create = "5m"
  }
}


resource "aws_network_interface" "web-eni" {
  subnet_id   = aws_subnet.web_subnet.id
  private_ips = ["172.16.10.100"]


  tags = {
    git_commit           = "d4e24fe7a0a581f3bfa744261636d6be1ea8bd9d"
    git_file             = "terraform/aws/ec2-clean.tf"
    git_last_modified_at = "2021-10-22 04:14:24"
    git_last_modified_by = "fefefe@gmail.com"
    git_modifiers        = "fefefe"
    git_org              = "fefefe8888"
    git_repo             = "terragoat"
    yor_trace            = "b21fcbc3-acea-4eea-8de5-f56f1f9c2470"
  }
}

# VPC Flow Logs to S3
resource "aws_flow_log" "vpcflowlogs" {
  log_destination      = aws_s3_bucket.flowbucket.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.web_vpc.id
  tags = {
    git_commit           = "d4e24fe7a0a581f3bfa744261636d6be1ea8bd9d"
    git_file             = "terraform/aws/ec2-clean.tf"
    git_last_modified_at = "2021-10-22 04:14:24"
    git_last_modified_by = "fefefe@gmail.com"
    git_modifiers        = "fefefe"
    git_org              = "fefefe8888"
    git_repo             = "terragoat"
    yor_trace            = "57458f33-bf17-4502-8457-fdafab525283"
  }
}

resource "aws_s3_bucket" "flowbucket" {
  bucket        = "${local.resource_prefix.value}-flowlogs"
  force_destroy = true
  tags = {
    git_commit           = "d4e24fe7a0a581f3bfa744261636d6be1ea8bd9d"
    git_file             = "terraform/aws/ec2-clean.tf"
    git_last_modified_at = "2021-10-22 04:14:24"
    git_last_modified_by = "fefefe@gmail.com"
    git_modifiers        = "fefefe"
    git_org              = "fefefe8888"
    git_repo             = "terragoat"
    yor_trace            = "16320281-2e5d-4e9a-ac2d-915c997f3e42"
  }
}

output "ec2_public_dns" {
  description = "Web Host Public DNS name"
  value       = aws_instance.web_host.public_dns
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.web_vpc.id
}

output "public_subnet" {
  description = "The ID of the Public subnet"
  value       = aws_subnet.web_subnet.id
}

output "public_subnet2" {
  description = "The ID of the Public subnet"
  value       = aws_subnet.web_subnet2.id
}
