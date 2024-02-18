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

resource "google_sql_database_instance" "main" {
  name             = var.name
  database_version = var.database_version
  region           = var.region
  deletion_protection = var.deletion_protection

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = var.tier
  }
}

variable "deletion_protection" {
  default = false
}

variable "name" {
  default = "main-instance-removeit"
}


variable "database_version" {
  default = "POSTGRES_15"
}

variable "tier" {
  default = "db-f1-micro"
}

variable "project" {}

variable "region" {
	default = "us-central1"
}


variable "zone" {
  default = "us-central1-a"
}

variable "credentials" {}
