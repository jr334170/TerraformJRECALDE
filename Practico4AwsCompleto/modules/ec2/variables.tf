variable "ami_id" { type = string }
variable "instance_type" { type = string }
variable "key_name" { type = string }
variable "subnet_id" { type = string }
variable "vpc_id" { type = string }
variable "instance_name" { type = string }
variable "allowed_ssh_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
variable "allowed_http_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
variable "allowed_egress_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
variable "ssh_port" {
  type    = number
  default = 22
}
variable "http_port" {
  type    = number
  default = 80
}
