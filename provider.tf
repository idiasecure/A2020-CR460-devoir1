provider "google" {
  project = var.project_id
  credentials = "account.json"
  region  = "us-central1"
  zone    = var.zone
}
