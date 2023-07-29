variable "vpc_cidr" {
  type    = string
  default = "10.123.0.0/24"
}

variable "access_ip" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
variable "main_instance_type" {
  type    = string
  default = "t2.medium"
}
variable "volume_size" {
  type    = number
  default = 8
}

variable "key_name" {
  type = string
}

variable "public_key_path" {
  type = string
}



variable "ssh_key_pairs" {
  description = "SSH Keys per environment, this must be created first"
  type        = map(string)
  default = {
    xtc-dev-us1          = "btc-dev-us1"
    xtc-dev-ayomide-usw2 = "development-usw2"

  }


  #Define additional tags 
  variable "additional_tags" {
    type        = map(any)
    description = "Additional resource tags"
    default = {
      owner        = "ayomide"
      team         = "SRA"
      billing_code = "XXXX"
      backup       = "weekly or Bi-weekly"
      managedBy    = "terraform"
    }
  }
}