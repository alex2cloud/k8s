output "master-ip" {
  value = google_compute_instance.k8s-master.network_interface.0.network_ip
}
output "master-pub-ip" {
  value = google_compute_instance.k8s-master.network_interface.0.access_config.0.nat_ip
}

output "worker01-ip" {
  value = google_compute_instance.k8s-worker01.network_interface.0.network_ip
}
output "worker01-pub-ip" {
  value = google_compute_instance.k8s-worker01.network_interface.0.access_config.0.nat_ip
}

output "worker02-ip" {
  value = google_compute_instance.k8s-worker02.network_interface.0.network_ip
}
output "worker02-pub-ip" {
  value = google_compute_instance.k8s-worker02.network_interface.0.access_config.0.nat_ip
}
