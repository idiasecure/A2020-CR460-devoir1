provider "google" {
  project = "a2020-cr420-devoir1"
  credentials = "account.json"
  region  = "us-central1"
  zone    = "us-central1-c"
}

# Création de instance1 Canard
resource "google_compute_instance" "instance1" {
  name         = "canard"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    subnetwork       = google_compute_subnetwork.prod-dmz.name
    access_config {
    }
  }

  tags=["public-web"]
  
   metadata_startup_script = "apt-get -y update && apt-get -y upgrade && apt-get -y install apache2 && systemctl start apache2"
}

# Création instance2 mouton
resource "google_compute_instance" "instance2" {
  name         = "mouton"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "fedora-coreos-cloud/fedora-coreos-next"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    subnetwork       = google_compute_subnetwork.prod-interne.name
    access_config {
    }
  }
}

# Création instance3 cheval
resource "google_compute_instance" "instance3" {
  name         = "cheval"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "fedora-coreos-cloud/fedora-coreos-next"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    subnetwork       = google_compute_subnetwork.prod-interne.name
  }
}

# Création instance4 fermier
resource "google_compute_instance" "instance4" {
  name         = "fermier"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-lts"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
  }
}

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


# Une règle de pare-feu pour autoriser le trafic web sur les instances ciblées public-web
resource "google_compute_firewall" "public-web" {
  name    = "public-web"
  network = google_compute_network.devoir1.name
  allow {
    protocol = "tcp"
    ports = ["80"]
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
resource "google_compute_firewall" "ssh" {
  name    = "ssh"
  network = google_compute_network.devoir1.name

  allow {
    protocol = "tcp"
  }
 destination_ranges = ["10.0.3.0/24"]
 }


# Pour serveur apache2
/*
 resource "google_compute_firewall" "http" {
  name    = "http"
  network = google_compute_subnetwork.prod-dmz.name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

}
*/
