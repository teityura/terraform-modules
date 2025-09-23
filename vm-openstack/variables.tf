variable "server_config" {
  description = "Configuration for the server."
  type = object({
    name = string
    flavor_id = string
    image_id = string
    key_pair = string
    volume_size = number
    security_groups = list(string)
    net_int = string
    net_ext = string
  })
}

variable "volume_config" {
  description = "Configuration for volume."
  type = object({
    volume_size = number
  })
  default = null
  nullable = true
}
