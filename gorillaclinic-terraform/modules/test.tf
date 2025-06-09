# Create static IP for load balancer
resource "google_compute_address" "static_ip" {
  name   = "petclinic-ingress-ip"
  region = "us-central1"
}

# Create DNS managed zone and record
resource "google_dns_managed_zone" "petclinic" {
  name        = "petclinic"
  dns_name    = "petclinic.example.com."
  description = "DNS zone for petclinic"
}

resource "google_dns_record_set" "petclinic_a" {
  name         = "petclinic.example.com."
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.petclinic.name
  rrdatas      = [google_compute_address.static_ip.address]
}