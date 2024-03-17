variable "aws_region" {
  default = "me-central-1"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ami" {
  default = "ami-013ec190c14420eb5"
}

variable "key_pair_name" {
  default = "deployer"
}