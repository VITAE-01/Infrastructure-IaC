resource "digitalocean_firewall" "web_firewall" {
  name        = var.firewall_name
  droplet_ids = digitalocean_droplet.web_server.*.id
  inbound_rule {
    protocol         = "tcp"
    port_range       = "8080"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "digitalocean_ssh_key" "my_ssh_key" {
  name       = var.ssh_key_name
  public_key = file("~/.ssh/vitae-01.pub")
}

resource "digitalocean_droplet" "web_server" {
  count    = var.droplet_count
  name     = "${var.server_name}-${count.index}"
  image    = var.image
  size     = var.size
  region   = var.region
  ssh_keys = [digitalocean_ssh_key.my_ssh_key.fingerprint]
  user_data = templatefile("initialize.yaml",
    { ssh_pub_key = file("~/.ssh/vitae-01.pub"),
  username = var.newuser })
  monitoring        = var.enable_monitoring
  backups           = var.enable_backups
  graceful_shutdown = var.enable_shutdwon
  tags              = var.tags
}

resource "digitalocean_floating_ip" "web_floating_ip" {
  count  = var.floating_ip_count
  region = var.region
}

resource "digitalocean_floating_ip_assignment" "web_floating_ip_assignment" {
  count      = var.floating_ip_count
  ip_address = digitalocean_floating_ip.web_floating_ip[count.index].ip_address
  droplet_id = digitalocean_droplet.web_server[count.index].id
}

resource "digitalocean_spaces_bucket" "my_bucket" {
  name   = var.bucket_name
  acl    = "private"
  region = var.region
  versioning {
    enabled = true
  }
}

