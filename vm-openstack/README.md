# OpenStack VM Module

This module creates an OpenStack server instance with a root volume from an image, a floating IP, and an optional data volume.

## Inputs

| Name | Description | Type | Default | Required |
| :--- | :--- | :--- | :--- | :---: |
| `server_config` | Configuration for the server, including root volume and network. | `object({name=string, flavor_id=string, image_id=string, key_pair=string, volume_size=number, security_groups=list(string), net_int=string, net_ext=string})` | n/a | yes |
| `volume_config` | Configuration for the optional data volume. If null, no data volume is created. | `object({volume_size=number})` | `null` | no |

## Outputs

| Name | Description | Type |
| :--- | :--- | :--- |
| `server_details` | Details of the created server, including IPs and IDs. | `object({id=string, name=string, private_ip=string, floating_ip=string, root_volume_id=string})` |
| `volume_details` | Details of the created data volume. Returns null if not created. | `object({id=string, device=string})` |