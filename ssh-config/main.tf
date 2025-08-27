resource "local_file" "conf" {
  content = templatefile("${path.module}/ssh_config.tftpl", {
    server   = var.server_details
    user = var.ssh_user
    key = var.ssh_key_path
  })

  filename        = "/etc/ssh/ssh_config.d/99-terra-${var.project_name}.conf"
  file_permission = "0644"
}
