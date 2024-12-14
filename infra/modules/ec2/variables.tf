variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "name" {
  type = string
}

variable "user_data" {
  type    = string
  default = ""
}

variable "ssh_key_name" {
  type    = string
  default = ""
}
