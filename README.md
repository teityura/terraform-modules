# terraform-modules

This repository is a collection of reusable Terraform modules.

## Available Modules

### [ssh-config](./ssh-config/)

A module to generate an SSH config file from server instance details. See the [module's README](./ssh-config/README.md) for more details.

#### Usage Example

``` hcl
module "ssh_config_generator" {
  source = "git::https://github.com/teityura/terraform-modules.git/ssh-config"

  server_details = {
    name        = "my-server"
    floating_ip = "192.0.2.1"
  }
  project_name   = "my-project"
  ssh_user       = "myuser"
  ssh_key_path   = "~/.ssh/id_rsa"
}
```
