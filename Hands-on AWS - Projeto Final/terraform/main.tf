variable "vpc_id" {
    default = "vpc-0228f4150437068b6"
}

variable "subnet_id" {
    default = "subnet-07da6d53668af70f6"
}

variable "key_name" {
    default = "chavessh"
}

resource "aws_instance" "ecommerce1" {
  ami           = "ami-032930428bf1abbff"
  instance_type = "t3a.medium"
  key_name = var.key_name
  subnet_id = var.subnet_id
  vpc_security_group_ids = [aws_security_group.permitir_ssh_http.id]
  associate_public_ip_address = true

  tags = {
    Name = "ecommerce1"
    ambiente = "bootcamp"
  }
}

resource "aws_security_group" "permitir_ssh_http" {
  name        = "permitir_ssh"
  description = "Permite SSH e HTTP na instancia EC2"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH to EC2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP to EC2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "permitir_ssh"
  }
}


