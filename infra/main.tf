variable "project_id" {
    type = string
    description = "GCP project ID"
}

variable "region" {
    type = string
    description = "GCP region"
    default = "us-central1"
}

provider "google" {
    project = var.project_id
    region = var.region
    version = "~> 3.45.0"
}

resource "google_dns_managed_zone" "dns_zone" {
    name = "raytung-com"
    dns_name = "raytung.com."
}

resource "google_dns_record_set" "record_set" {
    name = "${google_dns_managed_zone.dns_zone.dns_name}"
    type = "A"
    ttl = 300

    rrdatas = [
        "185.199.108.153",
        "186.199.109.153",
        "185.199.110.153",
        "185.199.111.153",
    ]

    managed_zone = google_dns_managed_zone.dns_zone.name
}