terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.53.0"
    }
  }
}

# --- 1. Root Volume ---
resource "openstack_blockstorage_volume_v3" "rvol" {
  name = "${var.server_config.name}-root"
  size = var.server_config.volume_size
  image_id = var.server_config.image_id
}

# --- 2. Server Instance ---
resource "openstack_compute_instance_v2" "serv" {
  name = var.server_config.name
  flavor_id = var.server_config.flavor_id
  key_pair = var.server_config.key_pair
  security_groups = var.server_config.security_groups

  block_device {
    uuid = openstack_blockstorage_volume_v3.rvol.id
    source_type = "volume"
    destination_type = "volume"
    boot_index = 0
    delete_on_termination = true
  }

  network {
    name = var.server_config.net_int
  }
}

# --- 3. Floating IP ---
resource "openstack_networking_floatingip_v2" "fip" {
  pool = var.server_config.net_ext
}

resource "openstack_compute_floatingip_associate_v2" "assoc" {
  floating_ip = openstack_networking_floatingip_v2.fip.address
  instance_id = openstack_compute_instance_v2.serv.id
}

# --- 4. Optional Data Volume (if volume_config is provided) ---
resource "openstack_blockstorage_volume_v3" "dvol" {
  count = var.volume_config != null ? 1 : 0

  name = "${var.server_config.name}-data"
  size = var.volume_config.volume_size
}

resource "openstack_compute_volume_attach_v2" "attach" {
  count = var.volume_config != null ? 1 : 0

  instance_id = openstack_compute_instance_v2.serv.id
  volume_id = openstack_blockstorage_volume_v3.dvol[0].id
}
