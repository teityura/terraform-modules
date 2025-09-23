output "server_details" {
  description = "Details of the created server."
  value = {
    id = openstack_compute_instance_v2.serv.id
    name = openstack_compute_instance_v2.serv.name
    private_ip = openstack_compute_instance_v2.serv.access_ip_v4
    floating_ip = openstack_networking_floatingip_v2.fip.address
    root_volume_id = openstack_blockstorage_volume_v3.rvol.id
  }
}

output "volume_details" {
  description = "Details of the created data volume."
  value = var.volume_config != null ? {
    id = openstack_blockstorage_volume_v3.dvol[0].id
    device = openstack_compute_volume_attach_v2.attach[0].device
  } : null
}
