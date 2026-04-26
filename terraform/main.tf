terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "nxt-tfstate-730335373015"
    key            = "nxt-openclaw/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "tfstate-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "nxt-openclaw"
      ManagedBy = "terraform"
    }
  }
}

# ---------------------------------------------------
# Ubuntu 22.04 LTS AMI (최신)
# ---------------------------------------------------
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ---------------------------------------------------
# Security Group
# ---------------------------------------------------
resource "aws_security_group" "openclaw" {
  name        = "openclaw-sg"
  description = "OpenClaw EC2 security group"

  # SSH
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  # OpenClaw Gateway
  ingress {
    description = "OpenClaw Gateway"
    from_port   = 18789
    to_port     = 18789
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  # HTTPS (Nginx 리버스 프록시 사용 시 필요 — 기본 설정에서는 SSH 터널 사용)
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "openclaw-sg"
    Project = "nxt-openclaw"
  }
}

# ---------------------------------------------------
# EC2 Instance
# ---------------------------------------------------
resource "aws_instance" "openclaw" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.openclaw.id]

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  # 인스턴스 생성 시 OpenClaw 자동 설치 (온보딩은 수동으로 진행)
  user_data = <<-EOF
    #!/bin/bash
    set -e
    curl -fsSL https://openclaw.ai/install.sh | sudo -u ubuntu bash -s -- --no-onboard
  EOF

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name    = "openclaw"
    Project = "nxt-openclaw"
  }
}

# ---------------------------------------------------
# Elastic IP
# ---------------------------------------------------
resource "aws_eip" "openclaw" {
  instance = aws_instance.openclaw.id
  domain   = "vpc"

  tags = {
    Name    = "openclaw-eip"
    Project = "nxt-openclaw"
  }
}
