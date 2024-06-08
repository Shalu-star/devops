terraform {
  required_providers {
    commercetools = {
      source = "labd/commercetools"
    }
  }
}

provider "commercetools" {
  client_id     = "94WmCsnLuxTbFFEEbslSV4TZ"
  client_secret = "DYhGW5c4_elzBJF8RA6q5EL1y4Zwg1Hg"
  project_key   = "composable-commerce123"
  scopes        = "manage_subscriptions:composable-commerce123 manage_project_settings:composable-commerce123 manage_extensions:composable-commerce123 manage_api_clients:composable-commerce123"
  api_url       = "https://api.us-central1.gcp.commercetools.com"
  token_url     = "https://auth.us-central1.gcp.commercetools.com"


}



resource "commercetools_project_settings" "my-project" {
  countries  = ["NL", "DE", "US", "CA"]
  currencies = ["EUR", "USD", "CAD"]
  languages  = ["nl", "de", "en", "fr-CA"]
  enable_search_index_orders   = true
  enable_search_index_products = true
}




resource "commercetools_api_client" "my-api-client" {
  name  = "My API Client"
  scope = ["manage_orders:composable-commerce123", "manage_payments:composable-commerce123"]

}

