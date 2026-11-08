# ---------------- Web server SG ----------------
resource "aws_security_group" "web" {
  name        = "${var.project_name}-web-sg"
  description = "Web server: HTTP from anywhere, SSH from my IP only"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from my IP only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "HTTP (Nginx: React app + /api reverse proxy)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.project_name}-web-sg" }
}

# ---------------- Database server SG ----------------
# No rule references the internet: only the web SG may reach it.
resource "aws_security_group" "db" {
  name        = "${var.project_name}-db-sg"
  description = "MongoDB server: SSH and 27017 only from the web server SG"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "SSH from web server (bastion / jump host)"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  ingress {
    description     = "MongoDB from web server (Express backend)"
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  egress {
    description = "All outbound (via NAT for package installs)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.project_name}-db-sg" }
}
