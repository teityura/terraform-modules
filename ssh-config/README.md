# SSH Config Module

This module generates an SSH config file based on server details.

## Usage

1.  Create `<proj_path>/config.yml`. See [./samples/config.yml.sample](./samples/config.yml.sample).

2.  Create `<proj_path>/terraform/locals.tf`. See [./samples/locals.tf.sample](./samples/locals.tf.sample).

3.  Create `<proj_path>/terraform/ssh.tf`. See [./samples/ssh.tf.sample](./samples/ssh.tf.sample).

## Inputs

| Name             | Description              | Type                               | Default | Required |
| ---------------- | ------------------------ | ---------------------------------- | ------- | :------: |
| `server_details` | Server params            | `object({name=string, floating_ip=string})` | n/a     |   yes    |
| `ssh_user`       | SSH user name            | `string`                           | n/a     |   yes    |
| `ssh_key_path`   | SSH private key path     | `string`                           | n/a     |   yes    |
| `project_name`   | Project name             | `string`                           | n/a     |   yes    |

## Outputs

| Name              | Description      | Type     |
| ----------------- | ---------------- | -------- |
| `ssh_config_path` | SSH config path. | `string` |
