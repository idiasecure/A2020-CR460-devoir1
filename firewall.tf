
# Une règle de pare-feu pour autoriser le trafic web sur les instances ciblées public-web
resource "google_compute_firewall" "public-web" {
  name    = "public-web"
  network = google_compute_network.devoir1.name
  allow {
    protocol = "tcp"
    ports = ["80", "443"]
  }
  target_tags=["public-web"]
}

# Une règle de pare-feu pour autoriser le trafic web sur les ports TCP 2846, 5462
resource "google_compute_firewall" "traitement" {
  name    = "traitement"
  network = google_compute_network.devoir1.name

  allow {
     protocol = "tcp"
     ports    = ["2846", "5462"]
   }

   target_tags=["traitement"]
   source_ranges = ["10.0.3.0/24"]

}


# Une règle de pare-feu pour autoriser la connexion ssh de l'internet vers les instances internes
resource "google_compute_firewall" "ssh-interne" {
  name    = "ssh-interne"
  network = google_compute_network.devoir1.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

target_tags=["interne"]

 }

 # Une règle de pare-feu pour autoriser le trafic web sur les ports TCP 2846, 5462 pour sous réseau interne
 resource "google_compute_firewall" "tcp-traitement" {
   name    = "tcp-traitement"
   network = google_compute_network.devoir1.name

   allow {
      protocol = "tcp"
      ports    = ["2846", "5462"]
    }

    target_tags=["interne"]
    source_ranges = ["10.0.4.0/24"]

 }
