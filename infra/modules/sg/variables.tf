variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "default_ports" {
  description = "List of default ports to open in the security group"
  type        = list(number)
  default     = [22]
}

variable "extra_ports" {
  description = "Additional ports to open in the security group"
  type        = list(number)
  default     = []
}
