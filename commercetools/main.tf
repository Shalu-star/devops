terraform {
  required_providers {
    commercetools = {
      source = "labd/commercetools"
      #source  = "registry.terraform.io/labd/commercetools"
    }
  }
}

/*
provider "commercetools" {
  client_id     = "yKFZ3vh706F-bTom2kSdhUi7"
  client_secret = "toBXjBFZJYAhjATGp8njIW5_T0cRq9Qq"
  project_key   = "composable-commerce123"
  scopes        = "manage_project:composable-commerce123"
  api_url       = "https://api.us-central1.gcp.commercetools.com"
  token_url     = "https://auth.us-central1.gcp.commercetools.com"
}
*/

provider "commercetools" {
  client_id     = "d0RDyffeVBYGwmDLD8tSRN-J"
  client_secret = "hiFBf3KQjT6q4MKDa9rZ_L22nJ-a8UQv"
  project_key   = "terraformtrial"
  scopes        = "manage_project:terraformtrial"
  api_url       = "https://api.us-central1.gcp.commercetools.com"
  token_url     = "https://auth.us-central1.gcp.commercetools.com"
}

provider "google" {
  credentials = file("jenkins-ms-5aa532b8865f.json")

  project = "jenkins-ms"
  region  = "us-central1"
  zone    = "us-central1-c"
}





