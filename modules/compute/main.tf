resource "aws_security_group" "custom_sg" {
    description = "Allow HTTP and SSH inbound traffic"
    name = "Custom-SG"
    vpc_id = var.vpc_id

    # Inbound Rules (Ingress)
    # Allow HTTP traffic from anywhere
    ingress {
        description = "HTTP from anywhere"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "SSH from anywhere"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Outbound Rules (Egress)
    # Allow all outbound traffic (Required for system updates/downloads)
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1" # "-1" means all protocols
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "web-traffic-sg"
    }
}

resource "aws_iam_role" "cloudwatch_role" {
  name = "ec2-cloudwatch-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    Name = "EC2_CloudWatch_Role"
  }
}

resource "aws_iam_role_policy_attachment" "cloudwatch_attach" {
  role       = aws_iam_role.cloudwatch_role.id
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-cloudwatch-instance-profile"
  role = aws_iam_role.cloudwatch_role.name
}

resource "aws_instance" "web_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type_id
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.custom_sg.id]
  associate_public_ip_address = true

  # LINK THE IAM INSTANCE PROFILE HERE
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "Public_Web_Server"
  }
}