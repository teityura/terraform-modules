variable "servers_detail" {
  description = "Server params"
  type = map(object({
    name = string
    floating_ip = string
    ssh_user = string
    ssh_key_path = string
  }))
}

variable "project_name" {
  type = string
  description = "Project name"
}
