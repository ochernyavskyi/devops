variable "region" {
  description = "Default region name"
  default = "eu-central-1"
}

variable "sg_ports" {
  description = "Default sg ports for http and https"
  type = list(number)
  default = [22, 80]
}