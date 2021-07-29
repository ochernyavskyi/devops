variable "region" {
  description = "Default region name"
  default = "eu-central-1"
}

variable "public_subnets" {
  default = ["172.16.0.0/24", "172.16.1.0/24"]
}