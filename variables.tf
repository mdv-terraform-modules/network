variable "tags" {}
variable "environment" {}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}
variable "public_subnet_names" {
  default = [
    "Public subnet-A",
    "Public subnet-B",
  ]
}
variable "private_subnet_names" {
  default = [
    "Private subnet-A",
    "Private subnet-B",
  ]
}
variable "db_subnet_names" {
  default = [
    "Database subnet-A",
    "Database subnet-B",
  ]
}
variable "public_cidr_blocks" {
  default = [
    "10.0.10.0/24",
    "10.0.11.0/24",
  ]
}
variable "private_cidr_blocks" {
  default = [
    "10.0.20.0/24",
    "10.0.21.0/24",
  ]
}
variable "db_cidr_blocks" {
  default = [
    "10.0.30.0/24",
    "10.0.31.0/24",
  ]
}
variable "http_port" {
  default = "80"
}
locals {
  any_cidr_block = "0.0.0.0/0"
}
