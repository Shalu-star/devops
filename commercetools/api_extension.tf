resource "commercetools_api_extension" "my-extension" {
  key = "my-extension-key"

  destination {
    type                 = "http"
    url                  = "https://us-central1-manoj-gcp-trial.cloudfunctions.net/cartApiExtension"
  }

  trigger {
    resource_type_id = "cart"
    actions          = ["Create", "Update"]
  }
}
