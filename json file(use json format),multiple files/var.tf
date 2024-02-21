variable "region" {
  type    = string
  default = "eu-west-3"

}


locals {
  variablebilu = jsondecode(file("basic.json"))
}