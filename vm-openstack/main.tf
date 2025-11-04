terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "~> 1.53.0"
    }
  }
}

# --- 1. Root Volume ---
resource "openstack_blockstorage_volume_v3" "rvol" {
  for_each = var.servers_config

  name = "${each.value.name}-root"
  size = each.value.volume_size
  image_id = each.value.image_id
}

# --- 2. Server Instance ---
resource "openstack_compute_instance_v2" "serv" {
  for_each = var.servers_config

  name = each.value.name
  flavor_id = each.value.flavor_id
  key_pair = each.value.key_pair
  security_groups = each.value.security_groups

  block_device {
    uuid = openstack_blockstorage_volume_v3.rvol[each.key].id
    source_type = "volume"
    destination_type = "volume"
    boot_index = 0
    delete_on_termination = true
  }

  network {
    name = each.value.net_int
  }
}

# --- 3. Floating IP ---
resource "openstack_networking_floatingip_v2" "fip" {
  for_each = var.servers_config
  pool = each.value.net_ext
}

resource "openstack_compute_floatingip_associate_v2" "assoc" {
  for_each = var.servers_config

  floating_ip = openstack_networking_floatingip_v2.fip[each.key].address
  instance_id = openstack_compute_instance_v2.serv[each.key].id
}

# --- 4. Optional Data Volume (if volume_config is provided for the key) ---
resource "openstack_blockstorage_volume_v3" "dvol" {
  for_each = {
    for k, v in var.servers_config : k => v
    if try(var.volumes_config[k].volume_size, 0) > 0
  }

  name = "${each.value.name}-data"
  size = var.volumes_config[each.key].volume_size
}

resource "openstack_compute_volume_attach_v2" "attach" {
  for_each = openstack_blockstorage_volume_v3.dvol

  instance_id = openstack_compute_instance_v2.serv[each.key].id
  volume_id = openstack_blockstorage_volume_v3.dvol[each.key].id
}
