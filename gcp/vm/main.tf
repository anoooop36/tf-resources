terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.10.0"
    }
  }
}

provider "google" {
  credentials = var.credentials
  project     = var.project
  region      = var.region
  zone	      = var.zone
}

resource "google_compute_instance" "vm_instance" {
  name         = var.vm_name
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc_network.self_link
    access_config {
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = var.net_name
  auto_create_subnetworks = "true"
}

resource "google_compute_disk" "default" {
  name  = var.name
  type  = var.type
  zone  = var.zone
  image = var.image
  labels = {
    environment = "dev"
  }
  size = var.size
  physical_block_size_bytes = var.block_size
}

variable "vm_name" {
  default = "tf-instance-removeit"
}

variable "net_name" {
  default = "tf-network-removeit"
}

variable "type" {
  default = "pd-standard"
}

variable "name" {
  default = "test-disk-removeit"
}

variable "zone" {
  default = "us-central1-a"
}

variable "image" {
  default = "debian-11-bullseye-v20220719"
}

variable "size" {
  default = 20
}

variable "block_size" {
  default = 4096
}

variable "project" {}

variable "region" {
	default = "us-central1"
}

variable "credentials" {}
