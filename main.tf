# Path: main.tf
# create worflow terraform google cloud platform
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.70.0"
    }
  }
}
# create provider google cloud platform
provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
  access_token = var.GCP_ACCESS_TOKEN
}
# create resource google_project
resource "google_project" "project" {
  name            = var.project
  project_id      = var.project
  org_id          = "1234567890"
  billing_account = "123456-ABCDEF-123456"
}
# create randomid for suffix name
resource "random_id" "instance" {
  byte_length = 5
}
# create resource google_compute_instance with name using variable name + suffix randomid
resource "google_compute_instance" "server" {
  project      = var.project
  name         = "${var.name}-${random_id.instance.hex}" 
  machine_type = var.machine_type
  allow_stopping_for_update = true
  zone         = var.zone
  tags         = var.tags
  metadata = {
    startup-script = var.metadata_startup_script
  }
  boot_disk {
    initialize_params {
      image = var.image
      labels = {
        "label" = "ubuntu-os-lts"
      }
      size = var.disk_size
      type = var.disk_type
    }
  }
  scratch_disk {
    interface = "SCSI"
  }
  network_interface {
    network = "default"
    access_config {
      # Include this section to give the VM an external IP address
    }
  }

  # copy folder recursive to instance using provisioner
  provisioner "file" {
    source      = var.source
    destination = var.destination
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apache2",
      "sudo service apache2 start",
      # Install Docker
      "sudo apt-get update",
      "sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\"",
      "sudo apt-get update",
      "sudo apt-get install -y docker-ce",
      # Install Docker Compose
      "sudo curl -L https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose",
      "sudo chmod +x /usr/local/bin/docker-compose",
    ]
  }
}

# create resource google_storage_bucket
resource "google_storage_bucket" "default" {
  name          = "${var.name}-${random_id.instance.hex}-bucket"
  project       = var.project
  force_destroy = false
  location      = var.region
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}
# create resource google_compute_firewall
resource "google_compute_firewall" "default-http" {
  project = var.project
  name    = "allow-http"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}
resource "google_compute_firewall" "default-https" {
  project = var.project
  name    = "allow-https"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
}
resource "google_compute_firewall" "default-ssh" {
  project = var.project
  name    = "allow-ssh"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  direction     = "INGRESS"
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
}