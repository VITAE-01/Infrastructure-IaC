output "webserver_floating_ip" {
  description = "The floating IP addresses of the web server droplets"
  value       = [for instance in digitalocean_floating_ip.web_floating_ip : instance.ip_address]
}