# OpenStack VM Module

This module creates multiple OpenStack server instances with root volumes from images, floating IPs, and optional data volumes.

## Inputs

| Name | Description | Type | Default | Required |
| :--- | :--- | :--- | :--- | :---: |
| `servers_config` | Configuration for multiple servers, including root volume and network settings. | `map(object({name=string, flavor_id=string, image_id=string, key_pair=string, volume_size=number, security_groups=list(string), net_int=string, net_ext=string, ssh_user=string, ssh_key_path=string}))` | n/a | yes |
| `volumes_config` | Configuration for optional data volumes per server. If empty, no data volumes are created. | `map(object({volume_size=number}))` | `{}` | no |

## Outputs

| Name | Description | Type |
| :--- | :--- | :--- |
| `servers_detail` | Details of the created servers, including IPs and IDs. | `map(object({id=string, name=string, private_ip=string, floating_ip=string, root_volume_id=string, ssh_user=string, ssh_key_path=string}))` |
| `volumes_detail` | Details of the created data volumes. Returns empty map if none created. | `map(object({id=string, device_path=string, mount_path=string}))` |