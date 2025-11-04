resource "local_file" "conf" {
  content = templatefile("${path.module}/ssh_config.tftpl", {
    servers = var.servers_detail
  })
  filename = "/etc/ssh/ssh_config.d/99-terra-${var.project_name}.conf"
  file_permission = "0644"
}
