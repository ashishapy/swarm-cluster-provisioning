# AWS credentials
variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_default_region" {}

variable "availability_zone" {}

# VMs ssh keys
variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can connect.
Example: ~/.ssh/terraform.pub
$ ssh-add ~/.ssh/terraform
DESCRIPTION
}

variable "private_key_path" {}

variable "key_name" {
  description = "Desired name of AWS Swarm cluster key pair"
  default     = "SwarmKey"
}

# Cluster VPC
variable "vpc_cidr" {
  description = "CIDR for VPC"
  default     = "10.240.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  default     = "10.240.0.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for private subnet"
  default     = "10.240.1.0/24"
}

# Docker Swarm cluster
variable "swarm_manager_token" {
  default = ""
}

variable "swarm_worker_token" {
  default = ""
}

variable "swarm_ami_id" {
  default = "unknown"
}

variable "swarm_manager_ip" {
  default = ""
}

variable "swarm_managers" {
  default = 3
}

variable "swarm_workers" {
  default = 2
}

variable "swarm_instance_type" {
  default = "t2.micro"
}

variable "swarm_init" {
  default = false
}
