variable "aws_region" {
  default = "me-central-1"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ami" {
  default = "ami-06e0a55b4f54d3e19"
}

variable "key_pair_name" {
  default = "deployer"
}