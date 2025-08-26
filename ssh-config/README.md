# SSH Config Module

This module generates an SSH config file based on server details.

## Usage

1.  Create `<proj_path>/config.yml`. See [./sample/config.yml.sample](./sample/config.yml.sample).

2.  Create `<proj_path>/terraform/locals.tf`. See [./sample/locals.tf.sample](./sample/locals.tf.sample).

3.  Create `<proj_path>/terraform/ssh.tf`. See [./sample/ssh.tf.sample](./sample/ssh.tf.sample).

## Inputs

| Name             | Description              | Type                               | Default | Required |
| ---------------- | ------------------------ | ---------------------------------- | ------- | :------: |
| `server_details` | Server params            | `object({name=string, floating_ip=string})` | n/a     |   yes    |
| `ssh_user`       | SSH user name            | `string`                           | n/a     |   yes    |
| `ssh_key_path`   | SSH private key path     | `string`                           | n/a     |   yes    |
| `project_name`   | Project name             | `string`                           | n/a     |   yes    |

## Outputs

This module does not provide any outputs, but it creates an SSH configuration file at `/etc/ssh/ssh_config.d/99-tf-${var.project_name}.conf`.
