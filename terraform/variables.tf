variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "ap-south-1"
}

variable "aws_profile" {
  description = "AWS CLI profile name configured with `aws configure`"
  type        = string
  default     = "default"
}

variable "project_name" {
  description = "Prefix used for naming every resource"
  type        = string
  default     = "travelmemory"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet (web server)"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet (database server)"
  type        = string
  default     = "10.0.2.0/24"
}

variable "my_ip" {
  description = "Your public IP in CIDR form, e.g. 49.36.10.20/32. Only this IP can SSH to the web server."
  type        = string

  validation {
    condition     = can(cidrhost(var.my_ip, 0))
    error_message = "my_ip must be a valid CIDR, e.g. 49.36.10.20/32."
  }
}

variable "public_key_path" {
  description = "Path to the SSH public key that will be uploaded as an EC2 key pair"
  type        = string
  default     = "~/.ssh/travelmemory.pub"
}

variable "private_key_path" {
  description = "Path to the matching SSH private key (only written into the Ansible inventory, never uploaded)"
  type        = string
  default     = "~/.ssh/travelmemory"
}

variable "web_instance_type" {
  description = "Instance type for the web server"
  type        = string
  default     = "t3.small"
}

variable "db_instance_type" {
  description = "Instance type for the database server"
  type        = string
  default     = "t3.micro"
}
