variable "ami" {
  default = {
    ubuntu = "ami-0df4b2961410d4cff"
    unix   = "ami-07b5c2e394fccab6e"
    redhat = "ami-062680d0a2ee357d0"
  }
}

variable "keypair" {
  default = "server-keypair"
}

variable "region" {
  default = "ap-southeast-2"
}

variable "az" {
  type = list(any)
}

variable "timeout" {
  type = number
}


