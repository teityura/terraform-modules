variable "server_details" {
  description = "Server params"
  type = object({
    name = string
    floating_ip = string
  })
}

variable "ssh_user" {
  type = string
  description = "SSH user name"
}

variable "ssh_key_path" {
  type = string
  description = "SSH private key path"
}

variable "project_name" {
  type = string
  description = "Project name"
}
