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


variable "table_schema" {
/*
  type = list(object({
    name = string
    type = string
    mode = string
    description = string
  }))
*/
  type = list(any)
  default =   [
    {
      "name": "permalink",
      "type": "STRING",
      "mode": "NULLABLE",
      "description": "The Permalink"
    },
    {
      "name": "state",
      "type": "STRING",
      "mode": "NULLABLE",
      "description": "State where the head office is located"
    }
  ]
}

locals {
  schema_json = jsonencode(var.table_schema)
}

resource "google_bigquery_dataset" "testDataset" {
  dataset_id                  = var.dataset_id
  friendly_name               = var.dataset_name
  description                 = "This is a test description"
  location                    = var.region
  default_table_expiration_ms = 3600000
  delete_contents_on_destroy = true

  labels = {
    env = "default"
  }
}

resource "google_bigquery_table" "testTableRemoveIt" {
  dataset_id = google_bigquery_dataset.testDataset.dataset_id
  table_id   = var.table_id
  deletion_protection=false

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = "default"
  }

  schema =  local.schema_json

}

variable "dataset_id" {
  default =  "testDataset"
}


variable "dataset_name" {
  default = "testDatasett"
}

variable "table_id" {
  default = "bqtableone_removeit"
}

variable "project" {}

variable "region" {
	default = "us-central1"
}

variable "zone" {
  default = "us-central1-a"
}

variable "credentials" {}
