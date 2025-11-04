output "servers_detail" {
  description = "Details of the created server."
  value = {
    for k, serv in openstack_compute_instance_v2.serv : k => {
      id = serv.id
      name = serv.name
      private_ip = serv.access_ip_v4
      floating_ip = openstack_networking_floatingip_v2.fip[k].address
      root_volume_id = openstack_blockstorage_volume_v3.rvol[k].id
      ssh_user = var.servers_config[k].ssh_user
      ssh_key_path = var.servers_config[k].ssh_key_path
    }
  }
}

output "volumes_detail" {
  description = "Details of the created data volume."
  value = {
    for k, dvol in openstack_blockstorage_volume_v3.dvol : k => {
      id = dvol.id
      device_path = try(openstack_compute_volume_attach_v2.attach[k].device, null)
      mount_path = try(var.volumes_config[k].volume_mount_path, null)
    }
  }
}
