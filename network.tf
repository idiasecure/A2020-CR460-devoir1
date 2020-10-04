# Création du réseau principal devoir1
resource "google_compute_network" "devoir1" {
  name                    = "devoir1"
  auto_create_subnetworks = "false"
}

# Création du sous-réseau prod-interne 10.0.3.0/24
resource "google_compute_subnetwork" "prod-interne" {
  name          = "prod-interne"
  ip_cidr_range = "10.0.3.0/24"
  region        = "us-central1"
  network       = google_compute_network.devoir1.self_link
}


# Création du sous-réseau prod-dmz 172.16.3.0/24
resource "google_compute_subnetwork" "prod-dmz" {
  name          = "prod-dmz"
  ip_cidr_range = "172.16.3.0/24"
  region        = "us-central1"
  network       = google_compute_network.devoir1.self_link
}

# Création du sous-réseau prod-traitement 10.0.2.0/24
resource "google_compute_subnetwork" "prod-traitement" {
  name          = "prod-traitement"
  ip_cidr_range = "10.0.2.0/24"
  region        = "us-central1"
  network       = google_compute_network.devoir1.self_link
}

# Création du sous-réseau TRAITEMENT  - L'adresse 10.0.4.0/24 a été choisie pour ce sous-réseau
resource "google_compute_subnetwork" "traitement" {
  name          = "traitement"
  ip_cidr_range = "10.0.4.0/24"
  region        = "us-central1"
  network       = google_compute_network.devoir1.self_link
}
