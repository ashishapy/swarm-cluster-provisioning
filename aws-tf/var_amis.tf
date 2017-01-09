# Docker 1.12.5 & Docker Compose 1.9.0 installed on Ubuntu 16.04 LTS (x64)
variable "aws_docker_amis" {
  description = "Base AMI to launch the instances with"

  default = {
    us-west-2 = "ami-53ff4d33"
  }
}
