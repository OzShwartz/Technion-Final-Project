variable "availability_zone" {
  type = string
  default = "us-east-1a"
}

variable "volume_size" {
  type = number
  default = 30
}

variable "volume_type" {
  type = string
  default = "gp3"
}

variable "name" {
  type = string
  default = "ebs_volume"
}

variable "device_name" {
  type = string
}

variable "instance_id" {
  type = string
}

variable "force_detach" {
  type = bool
  default = false
}
