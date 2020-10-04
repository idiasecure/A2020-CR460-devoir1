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
  tags=["interne"]

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
  tags=["traitement"]

  boot_disk {
    initialize_params {
      image = "fedora-coreos-cloud/fedora-coreos-next"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    subnetwork       = google_compute_subnetwork.prod-traitement.name
  }
}

# Création instance4 fermier
resource "google_compute_instance" "instance4" {
  name         = "fermier"
  machine_type = "f1-micro"
  tags=["fermier"]

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
