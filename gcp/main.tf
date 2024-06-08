terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.51.0"
    }
  }
}
provider "google" {
  credentials = file("jenkins-ms-5aa532b8865f.json")

  project = "jenkins-ms"
  region  = "us-central1"
  zone    = "us-central1-c"
}

