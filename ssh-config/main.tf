resource "local_file" "ssh_config" {
  content = templatefile("${path.module}/ssh_config.tftpl", {
    server   = var.server_details
    user = var.ssh_user
    key = var.ssh_key_path
  })

  filename        = "/etc/ssh/ssh_config.d/99-tf-${var.project_name}.conf"
  file_permission = "0644"
}
