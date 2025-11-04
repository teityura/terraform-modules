variable "servers_config" {
  description = "Configuration for the servers."
  type = map(object({
    name = string
    flavor_id = string
    image_id = string
    key_pair = string
    volume_size = number
    security_groups = list(string)
    net_int = string
    net_ext = string
    ssh_user = string
    ssh_key_path = string
  }))
}

variable "volumes_config" {
  description = "Configuration for volumes."
  type = map(object({
    volume_size = number
    volume_mount_path = optional(string)
  }))
  default = {}
}
