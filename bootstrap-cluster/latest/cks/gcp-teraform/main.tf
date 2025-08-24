terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_firewall" "allow-k8s-ssh" {
  name        = "allow-k8s-ssh"
  network     = google_compute_network.vpc_network.name
  description = "Allow access to k8s nodes"

  allow {
    protocol  = "tcp"
    ports     = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["k8s"]
}

resource "google_compute_firewall" "allow-k8s-internal-traffic" {
  name        = "allow-k8s-internal-traffic"
  network     = google_compute_network.vpc_network.name
  description = "Allow communication between k8s nodes"

  allow {
    protocol  = "tcp"
  }
  source_tags = ["k8s"]
  target_tags = ["k8s"]
}

resource "google_compute_instance" "k8s-master" {
  name         = "k8s-master"
  machine_type = "e2-standard-4"
  tags         = ["k8s"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-noble-amd64-v20250725"
      size = 50
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
  metadata = {
    startup-script-url = "https://storage.googleapis.com/startup-script-a2c/script/bootstrap_master-without-cni.sh"
  }
}
resource "google_compute_instance" "k8s-worker01" {
  name         = "k8s-worker01"
  machine_type = "e2-standard-4"
  tags         = ["k8s"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-noble-amd64-v20250725"
      size = 50
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
  metadata = {
    startup-script-url = "https://storage.googleapis.com/startup-script-a2c/script/bootstrap_worker.sh"
  }
}
resource "google_compute_instance" "k8s-worker02" {
  name         = "k8s-worker02"
  machine_type = "e2-standard-4"
  tags         = ["k8s"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-noble-amd64-v20250725"
      size = 50
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
  metadata = {
    startup-script-url = "https://storage.googleapis.com/startup-script-a2c/script/bootstrap_worker.sh"
  }
}
