# SSH Config Module

This module generates an SSH config file based on multiple server details.

## Inputs

| Name             | Description              | Type                               | Default | Required |
| ---------------- | ------------------------ | ---------------------------------- | ------- | :------: |
| `servers_detail` | Server params            | `map(object({name=string, floating_ip=string, ssh_user=string, ssh_key_path=string}))` | n/a     |   yes    |
| `project_name`   | Project name             | `string`                           | n/a     |   yes    |

## Outputs

| Name              | Description      | Type     |
| ----------------- | ---------------- | -------- |
| `ssh_config_path` | SSH config path. | `string` |
